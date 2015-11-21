package sx.backend.flash;

import flash.events.Event;
import flash.events.FocusEvent;
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
    /** Callback to invoke when cursor placed in this input */
    private var __onReceiveCursor : Null<Void->Void>;
    /** Callback to invoke when cursor removed from this input */
    private var __onLoseCursor : Null<Void->Void>;
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

        __addListeners();
    }


    /**
     * Set/remove callback which will be called when user changes content of text field
     */
    public function onTextChange (onTextChange:Null<String->Void>) : Void
    {
        __onTextChange = onTextChange;
    }


    /**
     * Set/remove callback which will be called when user places cursor in this input.
     */
    public function onReceiveCursor (callback:Null<Void->Void>) : Void
    {
        __onReceiveCursor = callback;
    }


    /**
     * Set/remove callback which will be called when user removes cursor from this input.
     */
    public function onLoseCursor (callback:Null<Void->Void>) : Void
    {
        __onLoseCursor = callback;
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
        __adjustHeightOneLine();
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
        __removeListeners();
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
        y = 0.5 * (__inputWidget.height.px - height);
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
        __adjustHeightOneLine();
    }


    /**
     * User placed cursor in this input
     */
    private function __onFocusIn (e:FocusEvent) : Void
    {
        #if (openfl && !nme && !flash)
            if (stage.focus != this) return;
        #end

        if (__onReceiveCursor != null) __onReceiveCursor();
    }


    /**
     * User removed cursor from this input
     */
    private function __onFocusOut (e:FocusEvent) : Void
    {
        if (__onLoseCursor != null) __onLoseCursor();
    }


    /**
     * Make flash TextField height be the size of one line.
     */
    private inline function __adjustHeightOneLine () : Void
    {
        #if flash
            var width = this.width;
            autoSize   = TextFieldAutoSize.LEFT;
            this.width = width;
            autoSize   = TextFieldAutoSize.NONE;
        //hack for non-flash targets of openfl&nme
        #else
            var metrics = getLineMetrics(0);
            height = metrics.height + 4;
            #if (openfl && !nme)
                if (text.length == 0) {
                    height += defaultTextFormat.size + 2;
                }
            #end
        #end
        __updatePosition();
    }


    /**
     * Add required event listeners
     */
    private inline function __addListeners () : Void
    {
        addEventListener(Event.CHANGE, __onChangeEvent);
        addEventListener(FocusEvent.FOCUS_IN, __onFocusIn);
        addEventListener(FocusEvent.FOCUS_OUT, __onFocusOut);
    }


    /**
     * Add required event listeners
     */
    private inline function __removeListeners () : Void
    {
        removeEventListener(Event.CHANGE, __onChangeEvent);
        removeEventListener(FocusEvent.FOCUS_IN, __onFocusIn);
        removeEventListener(FocusEvent.FOCUS_OUT, __onFocusOut);
    }

}//class TextInputRenderer