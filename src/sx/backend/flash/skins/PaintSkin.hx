package sx.backend.flash.skins;

import flash.display.Shape;
import sx.skins.base.PaintSkinBase;
import sx.widgets.Widget;



/**
 * Fill widget background with plain color
 *
 */
class PaintSkin extends PaintSkinBase
{
    /** Display object which will be used for drawings */
    private var canvas : Shape;


    /**
     * Constructor
     */
    public function new () : Void
    {
        super();

        canvas = new Shape();
    }


    /**
     * Called when skin is set for a `widget`.
     */
    override public function usedBy (widget:Widget) : Void
    {
        super.usedBy(widget);

        widget.backend.setSkinObject(canvas);
    }


    /**
     * If this skin is no longer in use by current widget
     */
    override public function removed () : Void
    {
        if (canvas.parent != null) {
            canvas.parent.removeChild(canvas);
        }

        super.removed();
    }


    /**
     * Called when skin visualization should be updated because of widget changes.
     */
    override public function refresh () : Void
    {
        canvas.graphics.clear();
        if (color >= 0) {
            canvas.graphics.beginFill(color, alpha);
            canvas.graphics.drawRect(0, 0, __widget.width.px, __widget.height.px);
            canvas.graphics.endFill();
        }
    }


}//class PaintSkin