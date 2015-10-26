package sx.backend.flash.skins;

import sx.properties.Orientation;
import sx.skins.base.PaintSkinBase;
import sx.Sx;

using sx.tools.PropertiesTools;
using sx.Sx;


/**
 * Fill widget background with plain color
 *
 */
class PaintSkin extends PaintSkinBase
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
            width  -= padding.sum(Horizontal);
            height -= padding.sum(Vertical);
        }

        if (hasBorder()) {
            var borderWidth = Math.round(border.width.px);
            canvas.graphics.lineStyle(borderWidth, border.color, border.alpha, (borderWidth & 1 == 1));
        }
        if (color >= 0) {
            canvas.graphics.beginFill(color, alpha);
        }

        if (Sx.pixelSnapping) {
            x = x.snap();
            y = y.snap();
            width = width.snap();
            height = height.snap();
        }

        if (hasCorners()) {
            var cornerRadius = corners.px.snap();
            canvas.graphics.drawRoundRect(x, y, width, height, cornerRadius * 2);
        } else {
            canvas.graphics.drawRect(x, y, width, height);
        }

        if (color >= 0) {
            canvas.graphics.endFill();
        }
    }


}//class PaintSkin