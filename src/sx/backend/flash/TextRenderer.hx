package sx.backend.flash;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import sx.backend.interfaces.ITextRenderer;
import sx.backend.TextFormat;
import sx.properties.metric.Units;
import sx.properties.metric.Size;
import sx.widgets.Text;
import sx.widgets.Widget;



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
    /** Cached value for text alignment */
    private var __align : #if nme String #else TextFormatAlign #end;


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
        __align    = TextFormatAlign.LEFT;

        __textWidget = textWidget;
        __textWidget.backend.addRendererObject(this);

        __textWidget.autoSize.onChange.add(__widgetAutoSizeChanged);
        __textWidget.padding.onChange.add(__widgetPaddingChanged);
        __textWidget.onResize.add(__widgetResized);
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

        if (__align != format.align && format.align != null) {
            __align = format.align;
            __updatePosition();
        }
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
    }


    /**
     * Notify renderer about changing width area available for content (pixels).
     */
    public function setAvailableAreaWidth (width:Float) : Void
    {
        this.width = width;
        __invokeOnResize();
    }


    /**
     * Notify renderer about changing height of the area available for content (pixels).
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
    private function __widgetAutoSizeChanged (widthChanged:Bool, heightChanged:Bool) : Void
    {
        if (widthChanged) {
            if (__textWidget.autoSize.width) {
                if (!wordWrap) wordWrap = true;
            } else {
                if (wordWrap) wordWrap = false;
            }
        }
    }


    /**
     * Update text position if padding changed
     */
    private function __widgetPaddingChanged (horizontalChanged:Bool, verticalChanged:Bool) : Void
    {
        __updatePosition();
    }


    /**
     * Update text position if widget resized.
     */
    private function __widgetResized (widget:Widget, changed:Size, previousUnits:Units, previousValue:Float) : Void
    {
        switch (__align) {
            case TextFormatAlign.LEFT :
            default                   : __updatePosition();
        }
    }


    /**
     * Invoke `onResize` if it's set
     */
    private inline function __invokeOnResize () : Void
    {
        if (__onResize != null) __onResize(getWidth(), getHeight());
    }


    /**
     * Update text position inside text widget
     */
    private inline function __updatePosition () : Void
    {
        y = __textWidget.padding.top.px;

        switch (__align) {
            case TextFormatAlign.RIGHT:
                x = __textWidget.width.px - __textWidget.padding.right.px - getWidth();
            case TextFormatAlign.CENTER:
                x = 0.5 * (__textWidget.width.px - getWidth());
            default :
                x = __textWidget.padding.left.px;
        }
    }

}//class TextRenderer