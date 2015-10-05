package sx.backend.flash;

import flash.display.Bitmap;
import sx.backend.interfaces.IBitmapRenderer;
import sx.widgets.Bmp;



/**
 * Renderer for `sx.widgets.Bmp`
 *
 */
class BitmapRenderer extends Bitmap implements IBitmapRenderer
{
    /** Owner widget */
    private var __bmp : Bmp;
    /** callback to invoke when content resized */
    private var __onResize : Float->Float->Void;


    /**
     * Constructor
     */
    public function new (bmp:Bmp) : Void
    {
        super();

        __bmp = bmp;
        __bmp.backend.addRendererObject(this);

        __bmp.padding.onComponentsChange.add(__widgetPaddingChanged);
    }


    /**
     * Set bitmap data to render
     */
    public function setBitmapData (bitmapData:BitmapData) : Void
    {
        this.bitmapData = bitmapData;

        __invokeOnResize();
    }


    /**
     * Returns original bitmap data width (pixels)
     */
    public inline function getBitmapDataWidth () : Float
    {
        if (bitmapData == null) {
            return 0;
        } else {
            return bitmapData.width;
        }
    }


    /**
     * Returns original bitmap data height (pixels)
     */
    public inline function getBitmapDataHeight () : Float
    {
        if (bitmapData == null) {
            return 0;
        } else {
            return bitmapData.height;
        }
    }


    /**
     * Change bitmap scaling
     */
    public function setScale (scaleX:Float, scaleY:Float) : Void
    {
        this.scaleX = scaleX;
        this.scaleY = scaleY;

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
    }


    /**
     * Notify renderer about changing width area available for content (pixels).
     */
    public function setAvailableAreaWidth (width:Float) : Void
    {
        //does not care about this
    }


    /**
     * Notify renderer about changing height area available for content (pixels).
     */
    public function setAvailableAreaHeight (height:Float) : Void
    {
        //does not care about this
    }


    /**
     * Method to cleanup and release this object for garbage collector.
     */
    public function dispose () : Void
    {
        __bmp      = null;
        __onResize = null;
        bitmapData = null;
    }


    /**
     * Invoke `onResize` if it's set
     */
    private inline function __invokeOnResize () : Void
    {
        if (__onResize != null) __onResize(getWidth(), getHeight());
    }


    /**
     * Update bitmap position if padding changed
     */
    private function __widgetPaddingChanged (horizontalChanged:Bool, verticalChanged:Bool) : Void
    {
        x = __bmp.padding.left.px;
        y = __bmp.padding.top.px;
    }

}//class BitmapRenderer