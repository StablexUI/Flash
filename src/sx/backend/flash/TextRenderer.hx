package sx.backend.flash;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import sx.backend.interfaces.ITextRenderer;
import sx.backend.TextFormat;
import sx.widgets.Text;



/**
 * Text rendering based on flash.text.TextField
 *
 */
class TextRenderer extends TextField implements ITextRenderer
{
    /** Owner of this renderer */
    private var __textWidget : Text;
    /** Callback to invoke when content size changes */
    private var __onResize : Null<Float->Float->Void>;


    /**
     * Constructor
     *
     * @param   textWidget      Owner of this renderer
     */
    public function new (textWidget:Text) : Void
    {
        super();

        multiline  = true;
        selectable = false;
        autoSize   = TextFieldAutoSize.LEFT;

        __textWidget = textWidget;
        __textWidget.backend.addRendererObject(this);
    }


    /**
     * Set content
     */
    public function setText (text:String) : Void
    {
        this.text = text;
        __invokeOnResize();
    }


    /**
     * Get text formatting settings.
     */
    public function getFormat () : TextFormat
    {
        return defaultTextFormat;
    }


    /**
     * Set text formatting settings.
     */
    public function setFormat (format:TextFormat) : Void
    {
        defaultTextFormat = format;
        setTextFormat(format);
        __invokeOnResize();
    }


    /**
     * Returns content width in pixels.
     */
    public function getWidth () : Float
    {
        return width;
    }


    /**
     * Returns content height in pixels.
     */
    public function getHeight () : Float
    {
        return height;
    }


    /**
     * Set/remove callback to invoke when content resized.
     *
     * Callback should receive content width and height (pixels) as arguments.
     */
    public function onResize (callback:Null<Float->Float->Void>) : Void
    {
        __onResize = callback;
        __updateWordWrap();
    }


    /**
     * Notify renderer about changing width area available for content (pixels).
     */
    public function setAvailableAreaWidth (width:Float) : Void
    {
        wordWrap   = true;
        this.width = width;

        __invokeOnResize();
    }


    /**
     * Notify renderer about changing height area available for content (pixels).
     */
    public function setAvailableAreaHeight (height:Float) : Void
    {
        //does not care about available height
    }


    /**
     * Method to cleanup and release this object for garbage collector.
     */
    public function dispose () : Void
    {
        __textWidget = null;
        if (__onResize != null) __onResize = null;
        if (parent != null) parent.removeChild(this);
    }


    /**
     * Update `wordWrap` flag according to text widget `autoSize.width` setting
     */
    private inline function __updateWordWrap () : Void
    {
        if (__textWidget.autoSize.width) {
            if (wordWrap) wordWrap = false;
        } else {
            if (!wordWrap) wordWrap = true;
        }
    }


    /**
     * Invoke `onResize` if it's set
     */
    private inline function __invokeOnResize () : Void
    {
        if (__onResize != null) __onResize(getWidth(), getHeight());
    }

}//class TextRenderer