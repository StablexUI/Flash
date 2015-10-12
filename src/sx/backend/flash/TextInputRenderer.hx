package sx.backend.flash;

import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import sx.backend.interfaces.ITextInputRenderer;
import sx.backend.TextFormat;
import sx.widgets.TextInput;



/**
 * Text rendering based on flash.text.TextField
 *
 */
class TextInputRenderer extends TextField implements ITextInputRenderer
{
    /** Owner of this renderer */
    private var __inputWidget : TextInput;
    /** Callback to invoke when content changed */
    private var __onTextChange : Null<String->Void>;
    /** Do not invoke `__onTextChange` */
    private var __suppressOnTextChange : Bool = false;


    /**
     * Constructor
     *
     * @param   inputWidget      Owner of this renderer
     */
    public function new (inputWidget:TextInput) : Void
    {
        super();

        type = TextFieldType.INPUT;

        __inputWidget = inputWidget;
        __inputWidget.backend.addRendererObject(this);
        __inputWidget.padding.onChange.add(__widgetPaddingChanged);

        __adjustHeightOneLine();

        addEventListener(Event.CHANGE, __onChangeEvent);
    }


    /**
     * Set/remove callback which will be called when user changes content of text field
     */
    public function onTextChange (onTextChange:String->Void) : Void
    {
        __onTextChange = onTextChange;
    }


    /**
     * Get curren content
     */
    public function getText () : String
    {
        return text;
    }


    /**
     * Set content
     */
    public function setText (text:String) : Void
    {
        __suppressOnTextChange = true;
        this.text = text;
        __suppressOnTextChange = false;
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
        __adjustHeightOneLine();
        __updatePosition();
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
     */
    public function onResize (callback:Null<Float->Float->Void>) : Void
    {
        //no need to handle resizing for text input
    }


    /**
     * Notify renderer about changing width area available for content (pixels).
     */
    public function setAvailableAreaWidth (width:Float) : Void
    {
        this.width = width;
        __updatePosition();
    }


    /**
     * Notify renderer about changing height of the area available for content (pixels).
     */
    public function setAvailableAreaHeight (height:Float) : Void
    {
        // this.height = height;
        __updatePosition();
    }


    /**
     * Method to cleanup and release this object for garbage collector.
     */
    public function dispose () : Void
    {
        removeEventListener(Event.CHANGE, __onChangeEvent);
        __inputWidget = null;
        if (__onTextChange != null) __onTextChange = null;
        if (parent != null) parent.removeChild(this);
    }


    /**
     * Update text position if padding changed
     */
    private function __widgetPaddingChanged (horizontalChanged:Bool, verticalChanged:Bool) : Void
    {
        __updatePosition();
    }


    /**
     * Update text position inside text widget
     */
    private inline function __updatePosition () : Void
    {
        x = __inputWidget.padding.left.px;
        y = __inputWidget.padding.top.px;
    }


    /**
     * Pass change events to widget
     */
    private function __onChangeEvent (e:Event) : Void
    {
        if (__onTextChange != null && !__suppressOnTextChange) {
            __suppressOnTextChange = true;
            __onTextChange(text);
            __suppressOnTextChange = false;
        }
    }


    /**
     * Make flash TextField height be the size of one line.
     */
    private inline function __adjustHeightOneLine () : Void
    {
        autoSize = TextFieldAutoSize.LEFT;
        width    = __inputWidget.width.px;
        autoSize = TextFieldAutoSize.NONE;
    }

}//class TextInputRenderer