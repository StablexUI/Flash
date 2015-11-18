package sx.backend.flash.skins;

import flash.geom.Rectangle;
import sx.properties.Orientation;
import sx.skins.base.Slice9SkinBase;

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
        if (__widget == null || __bitmapData == null || slice == null) return;

        var drawRect = new Rectangle(
            padding.left.px,
            padding.top.px,
            __widget.width.px - padding.sumPx(Orientation),
            w.h - paddingTop - paddingBottom);

        var src : Rectangle = new Rectangle();
        var dst : Rectangle = new Rectangle();

        var scaleX : Float = (drawRect.width >= srcRect.width ? 1 : drawRect.width / srcRect.width);
        var scaleY : Float = (drawRect.height >= srcRect.height ? 1 : drawRect.height / srcRect.height);
        //do not draw nothing
        if( scaleX <= 0 || scaleY <= 0 ){
            return;
        }

        //top left{
            src.x      = srcRect.x;
            src.y      = srcRect.y;
            src.width  = _sliceSize(this.slice[0], Std.int(srcRect.width));
            src.height = _sliceSize(this.slice[2], Std.int(srcRect.height));

            dst.x      = drawRect.x;
            dst.y      = drawRect.y;
            dst.width  = _sliceSize(this.slice[0], Std.int(srcRect.width)) * scaleX;
            dst.height = _sliceSize(this.slice[2], Std.int(srcRect.height)) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //top middle{
            src.x      = srcRect.x + _sliceSize(this.slice[0], Std.int(srcRect.width));
            src.y      = srcRect.y;
            src.width  = _sliceSize(this.slice[1] - this.slice[0], Std.int(srcRect.width));
            src.height = _sliceSize(this.slice[2], Std.int(srcRect.height));

            dst.x      = drawRect.x + _sliceSize(this.slice[0], Std.int(srcRect.width)) * scaleX;
            dst.y      = drawRect.y;
            dst.width  = drawRect.width - (_sliceSize(this.slice[0], Std.int(srcRect.width)) + (srcRect.width - _sliceSize(this.slice[1], Std.int(srcRect.width)))) * scaleX;
            dst.height = _sliceSize(this.slice[2], Std.int(srcRect.height)) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //top right{
            src.x      = srcRect.x + _sliceSize(this.slice[1], Std.int(srcRect.width));
            src.y      = srcRect.y;
            src.width  = srcRect.width - _sliceSize(this.slice[1], Std.int(srcRect.width));
            src.height = _sliceSize(this.slice[2], Std.int(srcRect.height));

            dst.x      = drawRect.x + drawRect.width - src.width * scaleX;
            dst.y      = drawRect.y;
            dst.width  = src.width * scaleX;
            dst.height = _sliceSize(this.slice[2], Std.int(srcRect.height)) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle left{
            src.x      = srcRect.x;
            src.y      = srcRect.y + _sliceSize(this.slice[2], Std.int(srcRect.height));
            src.width  = _sliceSize(this.slice[0], Std.int(srcRect.width));
            src.height = _sliceSize(this.slice[3] - this.slice[2], Std.int(srcRect.height));

            dst.x      = drawRect.x;
            dst.y      = drawRect.y + _sliceSize(this.slice[2], Std.int(srcRect.height)) * scaleY;
            dst.width  = _sliceSize(this.slice[0], Std.int(srcRect.width)) * scaleX;
            dst.height = drawRect.height - (_sliceSize(this.slice[2], Std.int(srcRect.height)) + (srcRect.height - _sliceSize(this.slice[3], Std.int(srcRect.height)))) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle middle{
            src.x      = srcRect.x + _sliceSize(this.slice[0], Std.int(srcRect.width));
            src.y      = srcRect.y + _sliceSize(this.slice[2], Std.int(srcRect.height));
            src.width  = _sliceSize(this.slice[1] - this.slice[0], Std.int(srcRect.width));
            src.height = _sliceSize(this.slice[3] - this.slice[2], Std.int(srcRect.height));

            dst.x      = drawRect.x + _sliceSize(this.slice[0], Std.int(srcRect.width)) * scaleX;
            dst.y      = drawRect.y + _sliceSize(this.slice[2], Std.int(srcRect.height)) * scaleY;
            dst.width  = drawRect.width - (_sliceSize(this.slice[0], Std.int(srcRect.width)) + (srcRect.width - _sliceSize(this.slice[1], Std.int(srcRect.width)))) * scaleX;
            dst.height = drawRect.height - (_sliceSize(this.slice[2], Std.int(srcRect.height)) + (srcRect.height - _sliceSize(this.slice[3], Std.int(srcRect.height)))) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle right{
            src.x      = srcRect.x + _sliceSize(this.slice[1], Std.int(srcRect.width));
            src.y      = srcRect.y + _sliceSize(this.slice[2], Std.int(srcRect.height));
            src.width  = srcRect.width - _sliceSize(this.slice[1], Std.int(srcRect.width));
            src.height = _sliceSize(this.slice[3] - this.slice[2], Std.int(srcRect.height));

            dst.x      = drawRect.x + drawRect.width - src.width * scaleX;
            dst.y      = drawRect.y + _sliceSize(this.slice[2], Std.int(srcRect.height)) * scaleY;
            dst.width  = src.width * scaleX;
            dst.height = drawRect.height - (_sliceSize(this.slice[2], Std.int(srcRect.height)) + (srcRect.height - _sliceSize(this.slice[3], Std.int(srcRect.height)))) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom left{
            src.x      = srcRect.x;
            src.y      = srcRect.y + _sliceSize(this.slice[3], Std.int(srcRect.height));
            src.width  = _sliceSize(this.slice[0], Std.int(srcRect.width));
            src.height = srcRect.height - _sliceSize(this.slice[3], Std.int(srcRect.height));

            dst.x      = drawRect.x;
            dst.y      = drawRect.y + drawRect.height - src.height * scaleY;
            dst.width  = _sliceSize(this.slice[0], Std.int(srcRect.width)) * scaleX;
            dst.height = src.height * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom middle{
            src.x      = srcRect.x + _sliceSize(this.slice[0], Std.int(srcRect.width));
            src.y      = srcRect.y + _sliceSize(this.slice[3], Std.int(srcRect.height));
            src.width  = _sliceSize(this.slice[1] - this.slice[0], Std.int(srcRect.width));
            src.height = srcRect.height - _sliceSize(this.slice[3], Std.int(srcRect.height));

            dst.x      = drawRect.x + _sliceSize(this.slice[0], Std.int(srcRect.width)) * scaleX;
            dst.y      = drawRect.y + drawRect.height - src.height * scaleY;
            dst.width  = drawRect.width - (_sliceSize(this.slice[0], Std.int(srcRect.width)) + (srcRect.width - _sliceSize(this.slice[1], Std.int(srcRect.width)))) * scaleX;
            dst.height = src.height * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom right{
            src.x      = srcRect.x + _sliceSize(this.slice[1], Std.int(srcRect.width));
            src.y      = srcRect.y + _sliceSize(this.slice[3], Std.int(srcRect.height));
            src.width  = srcRect.width - _sliceSize(this.slice[1], Std.int(srcRect.width));
            src.height = srcRect.height - _sliceSize(this.slice[3], Std.int(srcRect.height));

            dst.x      = drawRect.x + drawRect.width - src.width * scaleX;
            dst.y      = drawRect.y + drawRect.height - src.height * scaleY;
            dst.width  = src.width * scaleX;
            dst.height = src.height * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}
    }


}//class Slice9Skin