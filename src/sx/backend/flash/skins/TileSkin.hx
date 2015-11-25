package sx.backend.flash.skins;

import flash.geom.Matrix;
import sx.properties.Orientation;
import sx.skins.base.TileSkinBase;
import sx.Sx;

using sx.tools.PropertiesTools;
using sx.Sx;


/**
 * Tile widget background with specified bitmap
 *
 */
class TileSkin extends TileSkinBase
{


    /**
     * Called when skin visualization should be updated because of widget changes.
     */
    override public function refresh () : Void
    {
        canvas.graphics.clear();

        var x = 0.;
        var y = 0.;
        var width  = __widget.width.px;
        var height = __widget.height.px;
        if (hasPadding()) {
            x += padding.left.px;
            y += padding.top.px;
            width  -= padding.sumPx(Horizontal);
            height -= padding.sumPx(Vertical);
        }

        if (Sx.pixelSnapping) {
            x = x.snap();
            y = y.snap();
            width = width.snap();
            height = height.snap();
        }

        if (hasBorder()) {
            var borderWidth = Math.round(border.width.px);
            canvas.graphics.lineStyle(borderWidth, border.color, border.alpha, (borderWidth & 1 == 1));
        }
        if (bitmapData != null) {
            if (hasPadding()) {
                var mx = new Matrix();
                mx.translate(padding.left.px, padding.top.px);
                canvas.graphics.beginBitmapFill(bitmapData, mx, true, smooth);
            } else {
                canvas.graphics.beginBitmapFill(bitmapData, null, true, smooth);
            }
        }

        if (hasCorners()) {
            var cornerRadius = corners.px.snap();
            canvas.graphics.drawRoundRect(x, y, width, height, cornerRadius * 2);
        } else {
            canvas.graphics.drawRect(x, y, width, height);
        }

        if (bitmapData != null) {
            canvas.graphics.endFill();
        }
    }


}//class TileSkin