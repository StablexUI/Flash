package sx.backend.flash.skins;

import flash.display.Sprite;
import sx.skins.base.SkinBase;
import sx.widgets.Widget;



/**
 * Base class for
 *
 */
class Skin extends SkinBase
{

    /** Display object which will be used for drawings */
    private var canvas : Sprite;


    /**
     * Constructor
     */
    public function new () : Void
    {
        super();

        canvas = new Sprite();
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

}//class Skin