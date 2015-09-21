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
     * Used internally to call `onChange` if it is set when some property of this skin is changed.
     */
    override private function __invokeOnChange () : Void
    {
        canvas.graphics.clear();
        if (color >= 0) {
            canvas.graphics.beginFill(color, alpha);
            canvas.graphics.drawRect(0, 0, 1, 1);
            canvas.graphics.endFill();
        }

        super.__invokeOnChange();
    }


    /**
     * Called when skin visualization should be updated because of widget changes.
     */
    override private function refresh () : Void
    {
        canvas.width  = widget.width.px;
        canvas.height = widget.height.px;
    }


}//class PaintSkin