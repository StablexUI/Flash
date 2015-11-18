package sx.backend.flash.skins;

import flash.display.Graphics;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import sx.exceptions.InvalidArgumentException;
import sx.properties.Orientation;
import sx.skins.base.Slice9SkinBase;
import sx.widgets.Widget;

using sx.tools.PropertiesTools;


/**
 * 9 slice scaling skin.
 *
 */
class Slice9Skin extends Slice9SkinBase
{
    /** For internal usage */
    private var __drawRect : Rectangle = null;
    private var __srcRect  : Rectangle = null;
    private var __src      : Rectangle = null;
    private var __dst      : Rectangle = null;


    /**
     * Constructor
     */
    public function new () : Void
    {
        super();

        __srcRect  = new Rectangle();
        __drawRect = new Rectangle();
        __src      = new Rectangle();
        __dst      = new Rectangle();
    }


    /**
     * Called when skin visualization should be updated because of widget changes.
     */
    override public function refresh () : Void
    {
        if (__widget == null || bitmapData == null) return;

        if (slice == null) {
            throw new InvalidArgumentException('Slice9Skin.slice is not set');
        }
        if (slice.length != 4) {
            throw new InvalidArgumentException('Slice9Skin.slice should contain exactly 4 values');
        }
        canvas.graphics.clear();

        __drawRect.x      = padding.left.px;
        __drawRect.y      = padding.top.px;
        __drawRect.width  = __widget.width.px - padding.sumPx(Horizontal);
        __drawRect.height = __widget.height.px - padding.sumPx(Vertical);

        __srcRect.width = bitmapData.width;
        __srcRect.height = bitmapData.height;

        var scaleX : Float = (__drawRect.width >= __srcRect.width ? 1 : __drawRect.width / __srcRect.width);
        var scaleY : Float = (__drawRect.height >= __srcRect.height ? 1 : __drawRect.height / __srcRect.height);
        //do not draw anything
        if( scaleX <= 0 || scaleY <= 0 ){
            return;
        }

        __leftTop(slice[0], slice[2], scaleX, scaleY);
        __centerTop(slice[0], slice[1], slice[2], scaleX, scaleY);
        __rightTop(slice[1], slice[2], scaleX, scaleY);
        __leftMiddle(slice[0], slice[2], slice[3], scaleX, scaleY);
        __centerMiddle(slice[0], slice[1], slice[2], slice[3], scaleX, scaleY);
        __rightMiddle(slice[1], slice[2], slice[3], scaleX, scaleY);
        __leftBottom(slice[0], slice[3], scaleX, scaleY);
        __centerBottom(slice[0], slice[1], slice[3], scaleX, scaleY);
        __rightBottom(slice[1], slice[2], slice[3], scaleX, scaleY);
    }


    /**
     * Draw left-top part of image
     */
    private function __leftTop (left:Float, top:Float, scaleX:Float, scaleY:Float) : Void
    {
        __src.x      = __srcRect.x;
        __src.y      = __srcRect.y;
        __src.width  = __sliceSize(left, __srcRect.width);
        __src.height = __sliceSize(top, __srcRect.height);

        __dst.x      = __drawRect.x;
        __dst.y      = __drawRect.y;
        __dst.width  = __sliceSize(left, __srcRect.width) * scaleX;
        __dst.height = __sliceSize(top, __srcRect.height) * scaleY;

        __skinDrawSlice(bitmapData, __src, __dst);
    }


    /**
     * Draw center-top part of image
     */
    private function __centerTop (left:Float, right:Float, top:Float, scaleX:Float, scaleY:Float) : Void
    {
        __src.x      = __srcRect.x + __sliceSize(left, __srcRect.width);
        __src.y      = __srcRect.y;
        __src.width  = __sliceSize(right - left, __srcRect.width);
        __src.height = __sliceSize(top, __srcRect.height);

        __dst.x      = __drawRect.x + __sliceSize(left, __srcRect.width) * scaleX;
        __dst.y      = __drawRect.y;
        __dst.width  = __drawRect.width - (__sliceSize(left, __srcRect.width) + (__srcRect.width - __sliceSize(right, __srcRect.width))) * scaleX;
        __dst.height = __sliceSize(top, __srcRect.height) * scaleY;

        __skinDrawSlice(bitmapData, __src, __dst);
    }


    /**
     * Draw right-top part of image
     */
    private function __rightTop (right:Float, top:Float, scaleX:Float, scaleY:Float) : Void
    {
        __src.x      = __srcRect.x + __sliceSize(right, __srcRect.width);
        __src.y      = __srcRect.y;
        __src.width  = __srcRect.width - __sliceSize(right, __srcRect.width);
        __src.height = __sliceSize(top, __srcRect.height);

        __dst.x      = __drawRect.x + __drawRect.width - __src.width * scaleX;
        __dst.y      = __drawRect.y;
        __dst.width  = __src.width * scaleX;
        __dst.height = __sliceSize(top, __srcRect.height) * scaleY;

        __skinDrawSlice(bitmapData, __src, __dst);
    }


    /**
     * Draw left-middle part of image
     */
    private function __leftMiddle (left:Float, top:Float, bottom:Float, scaleX:Float, scaleY:Float) : Void
    {
        __src.x      = __srcRect.x;
        __src.y      = __srcRect.y + __sliceSize(top, __srcRect.height);
        __src.width  = __sliceSize(left, __srcRect.width);
        __src.height = __sliceSize(bottom - top, __srcRect.height);

        __dst.x      = __drawRect.x;
        __dst.y      = __drawRect.y + __sliceSize(top, __srcRect.height) * scaleY;
        __dst.width  = __sliceSize(left, __srcRect.width) * scaleX;
        __dst.height = __drawRect.height - (__sliceSize(top, __srcRect.height) + (__srcRect.height - __sliceSize(bottom, __srcRect.height))) * scaleY;

        __skinDrawSlice(bitmapData, __src, __dst);
    }


    /**
     * Draw center-Middle part of image
     */
    private function __centerMiddle (left:Float, right:Float, top:Float, bottom:Float, scaleX:Float, scaleY:Float) : Void
    {
        __src.x      = __srcRect.x + __sliceSize(left, __srcRect.width);
        __src.y      = __srcRect.y + __sliceSize(top, __srcRect.height);
        __src.width  = __sliceSize(right - left, __srcRect.width);
        __src.height = __sliceSize(bottom - top, __srcRect.height);

        __dst.x      = __drawRect.x + __sliceSize(left, __srcRect.width) * scaleX;
        __dst.y      = __drawRect.y + __sliceSize(top, __srcRect.height) * scaleY;
        __dst.width  = __drawRect.width - (__sliceSize(left, __srcRect.width) + (__srcRect.width - __sliceSize(right, __srcRect.width))) * scaleX;
        __dst.height = __drawRect.height - (__sliceSize(top, __srcRect.height) + (__srcRect.height - __sliceSize(bottom, __srcRect.height))) * scaleY;

        __skinDrawSlice(bitmapData, __src, __dst);
    }


    /**
     * Draw right-Middle part of image
     */
    private function __rightMiddle (right:Float, top:Float, bottom:Float, scaleX:Float, scaleY:Float) : Void
    {
        __src.x      = __srcRect.x + __sliceSize(right, __srcRect.width);
        __src.y      = __srcRect.y + __sliceSize(top, __srcRect.height);
        __src.width  = __srcRect.width - __sliceSize(right, __srcRect.width);
        __src.height = __sliceSize(bottom - top, __srcRect.height);

        __dst.x      = __drawRect.x + __drawRect.width - __src.width * scaleX;
        __dst.y      = __drawRect.y + __sliceSize(top, __srcRect.height) * scaleY;
        __dst.width  = __src.width * scaleX;
        __dst.height = __drawRect.height - (__sliceSize(top, __srcRect.height) + (__srcRect.height - __sliceSize(bottom, __srcRect.height))) * scaleY;

        __skinDrawSlice(bitmapData, __src, __dst);
    }


    /**
     * Draw left-Bottom part of image
     */
    private function __leftBottom (left:Float, bottom:Float, scaleX:Float, scaleY:Float) : Void
    {
        __src.x      = __srcRect.x;
        __src.y      = __srcRect.y + __sliceSize(bottom, __srcRect.height);
        __src.width  = __sliceSize(left, __srcRect.width);
        __src.height = __srcRect.height - __sliceSize(bottom, __srcRect.height);

        __dst.x      = __drawRect.x;
        __dst.y      = __drawRect.y + __drawRect.height - __src.height * scaleY;
        __dst.width  = __sliceSize(left, __srcRect.width) * scaleX;
        __dst.height = __src.height * scaleY;

        __skinDrawSlice(bitmapData, __src, __dst);
    }


    /**
     * Draw center-Bottom part of image
     */
    private function __centerBottom (left:Float, right:Float, bottom:Float, scaleX:Float, scaleY:Float) : Void
    {
        __src.x      = __srcRect.x + __sliceSize(left, __srcRect.width);
        __src.y      = __srcRect.y + __sliceSize(bottom, __srcRect.height);
        __src.width  = __sliceSize(right - left, __srcRect.width);
        __src.height = __srcRect.height - __sliceSize(bottom, __srcRect.height);

        __dst.x      = __drawRect.x + __sliceSize(left, __srcRect.width) * scaleX;
        __dst.y      = __drawRect.y + __drawRect.height - __src.height * scaleY;
        __dst.width  = __drawRect.width - (__sliceSize(left, __srcRect.width) + (__srcRect.width - __sliceSize(right, __srcRect.width))) * scaleX;
        __dst.height = __src.height * scaleY;

        __skinDrawSlice(bitmapData, __src, __dst);
    }


    /**
     * Draw right-bottom part of image
     */
    private function __rightBottom (right:Float, top:Float, bottom:Float, scaleX:Float, scaleY:Float) : Void
    {
        __src.x      = __srcRect.x + __sliceSize(right, __srcRect.width);
        __src.y      = __srcRect.y + __sliceSize(bottom, __srcRect.height);
        __src.width  = __srcRect.width - __sliceSize(right, __srcRect.width);
        __src.height = __srcRect.height - __sliceSize(bottom, __srcRect.height);

        __dst.x      = __drawRect.x + __drawRect.width - __src.width * scaleX;
        __dst.y      = __drawRect.y + __drawRect.height - __src.height * scaleY;
        __dst.width  = __src.width * scaleX;
        __dst.height = __src.height * scaleY;

        __skinDrawSlice(bitmapData, __src, __dst);
    }


    /**
     * Draw slice for 9-slice scaling
     */
    private function __skinDrawSlice(bitmapData:BitmapData, src:Rectangle, dst:Rectangle) : Void
    {
        var mx = new Matrix();
        mx.translate(-src.x, -src.y);
        mx.scale(dst.width / src.width, dst.height / src.height);
        mx.translate(dst.x, dst.y);

        canvas.graphics.beginBitmapFill(bitmapData, mx, false, smooth);
        canvas.graphics.drawRect(dst.x, dst.y, dst.width, dst.height);
        canvas.graphics.endFill();
    }

}//class Slice9Skin