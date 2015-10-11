package sx.backend.flash.skins;

import sx.properties.Orientation;
import sx.skins.base.PaintSkinBase;

using sx.tools.PropertiesTools;


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
            canvas.graphics.lineStyle(border.width.px, border.color, border.alpha);
        }
        if (color >= 0) {
            canvas.graphics.beginFill(color, alpha);
        }

        if (hasCorners()) {
            canvas.graphics.drawRoundRect(x, y, width, height, corners.px);
        } else {
            canvas.graphics.drawRect(x, y, width, height);
        }

        if (color >= 0) {
            canvas.graphics.endFill();
        }
    }


}//class PaintSkin