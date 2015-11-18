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

        var drawRect = new Rectangle(
            padding.left.px,
            padding.top.px,
            __widget.width.px - padding.sumPx(Horizontal),
            __widget.height.px - padding.sumPx(Vertical)
        );
        var srcRect = bitmapData.rect;

        var src = new Rectangle();
        var dst = new Rectangle();

        var scaleX : Float = (drawRect.width >= srcRect.width ? 1 : drawRect.width / srcRect.width);
        var scaleY : Float = (drawRect.height >= srcRect.height ? 1 : drawRect.height / srcRect.height);
        //do not draw anything
        if( scaleX <= 0 || scaleY <= 0 ){
            return;
        }

        //top left{
            src.x      = srcRect.x;
            src.y      = srcRect.y;
            src.width  = _sliceSize(slice[0], srcRect.width);
            src.height = _sliceSize(slice[2], srcRect.height);

            dst.x      = drawRect.x;
            dst.y      = drawRect.y;
            dst.width  = _sliceSize(slice[0], srcRect.width) * scaleX;
            dst.height = _sliceSize(slice[2], srcRect.height) * scaleY;

            __skinDrawSlice(bitmapData, src, dst);
        //}

        //top middle{
            src.x      = srcRect.x + _sliceSize(slice[0], srcRect.width);
            src.y      = srcRect.y;
            src.width  = _sliceSize(slice[1] - slice[0], srcRect.width);
            src.height = _sliceSize(slice[2], srcRect.height);

            dst.x      = drawRect.x + _sliceSize(slice[0], srcRect.width) * scaleX;
            dst.y      = drawRect.y;
            dst.width  = drawRect.width - (_sliceSize(slice[0], srcRect.width) + (srcRect.width - _sliceSize(slice[1], srcRect.width))) * scaleX;
            dst.height = _sliceSize(slice[2], srcRect.height) * scaleY;

            __skinDrawSlice(bitmapData, src, dst);
        //}

        //top right{
            src.x      = srcRect.x + _sliceSize(slice[1], srcRect.width);
            src.y      = srcRect.y;
            src.width  = srcRect.width - _sliceSize(slice[1], srcRect.width);
            src.height = _sliceSize(slice[2], srcRect.height);

            dst.x      = drawRect.x + drawRect.width - src.width * scaleX;
            dst.y      = drawRect.y;
            dst.width  = src.width * scaleX;
            dst.height = _sliceSize(slice[2], srcRect.height) * scaleY;

            __skinDrawSlice(bitmapData, src, dst);
        //}

        //middle left{
            src.x      = srcRect.x;
            src.y      = srcRect.y + _sliceSize(slice[2], srcRect.height);
            src.width  = _sliceSize(slice[0], srcRect.width);
            src.height = _sliceSize(slice[3] - slice[2], srcRect.height);

            dst.x      = drawRect.x;
            dst.y      = drawRect.y + _sliceSize(slice[2], srcRect.height) * scaleY;
            dst.width  = _sliceSize(slice[0], srcRect.width) * scaleX;
            dst.height = drawRect.height - (_sliceSize(slice[2], srcRect.height) + (srcRect.height - _sliceSize(slice[3], srcRect.height))) * scaleY;

            __skinDrawSlice(bitmapData, src, dst);
        //}

        //middle middle{
            src.x      = srcRect.x + _sliceSize(slice[0], srcRect.width);
            src.y      = srcRect.y + _sliceSize(slice[2], srcRect.height);
            src.width  = _sliceSize(slice[1] - slice[0], srcRect.width);
            src.height = _sliceSize(slice[3] - slice[2], srcRect.height);

            dst.x      = drawRect.x + _sliceSize(slice[0], srcRect.width) * scaleX;
            dst.y      = drawRect.y + _sliceSize(slice[2], srcRect.height) * scaleY;
            dst.width  = drawRect.width - (_sliceSize(slice[0], srcRect.width) + (srcRect.width - _sliceSize(slice[1], srcRect.width))) * scaleX;
            dst.height = drawRect.height - (_sliceSize(slice[2], srcRect.height) + (srcRect.height - _sliceSize(slice[3], srcRect.height))) * scaleY;

            __skinDrawSlice(bitmapData, src, dst);
        //}

        //middle right{
            src.x      = srcRect.x + _sliceSize(slice[1], srcRect.width);
            src.y      = srcRect.y + _sliceSize(slice[2], srcRect.height);
            src.width  = srcRect.width - _sliceSize(slice[1], srcRect.width);
            src.height = _sliceSize(slice[3] - slice[2], srcRect.height);

            dst.x      = drawRect.x + drawRect.width - src.width * scaleX;
            dst.y      = drawRect.y + _sliceSize(slice[2], srcRect.height) * scaleY;
            dst.width  = src.width * scaleX;
            dst.height = drawRect.height - (_sliceSize(slice[2], srcRect.height) + (srcRect.height - _sliceSize(slice[3], srcRect.height))) * scaleY;

            __skinDrawSlice(bitmapData, src, dst);
        //}

        //bottom left{
            src.x      = srcRect.x;
            src.y      = srcRect.y + _sliceSize(slice[3], srcRect.height);
            src.width  = _sliceSize(slice[0], srcRect.width);
            src.height = srcRect.height - _sliceSize(slice[3], srcRect.height);

            dst.x      = drawRect.x;
            dst.y      = drawRect.y + drawRect.height - src.height * scaleY;
            dst.width  = _sliceSize(slice[0], srcRect.width) * scaleX;
            dst.height = src.height * scaleY;

            __skinDrawSlice(bitmapData, src, dst);
        //}

        //bottom middle{
            src.x      = srcRect.x + _sliceSize(slice[0], srcRect.width);
            src.y      = srcRect.y + _sliceSize(slice[3], srcRect.height);
            src.width  = _sliceSize(slice[1] - slice[0], srcRect.width);
            src.height = srcRect.height - _sliceSize(slice[3], srcRect.height);

            dst.x      = drawRect.x + _sliceSize(slice[0], srcRect.width) * scaleX;
            dst.y      = drawRect.y + drawRect.height - src.height * scaleY;
            dst.width  = drawRect.width - (_sliceSize(slice[0], srcRect.width) + (srcRect.width - _sliceSize(slice[1], srcRect.width))) * scaleX;
            dst.height = src.height * scaleY;

            __skinDrawSlice(bitmapData, src, dst);
        //}

        //bottom right{
            src.x      = srcRect.x + _sliceSize(slice[1], srcRect.width);
            src.y      = srcRect.y + _sliceSize(slice[3], srcRect.height);
            src.width  = srcRect.width - _sliceSize(slice[1], srcRect.width);
            src.height = srcRect.height - _sliceSize(slice[3], srcRect.height);

            dst.x      = drawRect.x + drawRect.width - src.width * scaleX;
            dst.y      = drawRect.y + drawRect.height - src.height * scaleY;
            dst.width  = src.width * scaleX;
            dst.height = src.height * scaleY;

            __skinDrawSlice(bitmapData, src, dst);
        //}
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