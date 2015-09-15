package sx.backend.flash.skins;

import sx.skins.base.SkinBase;
import sx.widgets.Widget;



/**
 * Base class for
 *
 */
class Skin extends SkinBase
{

    /** Widget this skin is currently applied to */
    private var widget : Widget;


    /**
     * Called when skin is set for a `widget`.
     * Don't perform any actions (like drawing) with `widget` here. Just store a reference to `widget` if required.
     */
    override private function usedBy (widget:Widget) : Void
    {
        this.widget = widget;
    }


    /**
     * If this skin is no longer in use by current widget
     */
    override private function removed () : Void
    {
        widget = null;
    }


    /**
     * Called when skin visualization should be updated
     */
    @:allow(sx.backend.flash.Backend)
    private function refresh () : Void
    {

    }


}//class Skin