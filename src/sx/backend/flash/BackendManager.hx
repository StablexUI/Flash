package sx.backend.flash;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import sx.backend.Backend;
import sx.backend.BitmapRenderer;
import sx.backend.interfaces.IBackendManager;
import sx.backend.TextRenderer;
import sx.input.PointerManager;
import sx.widgets.Bmp;
import sx.widgets.Text;
import sx.widgets.Widget;



/**
 * Backend factory implementation
 *
 */
class BackendManager implements IBackendManager
{
    /** If mouse events listeners attached to stage */
    static private var __mouseEventsHandled : Bool = false;


    /**
     * Translate flash mouse & touch events to StablexUI signals
     */
    static public function handlePointers () : Void
    {
        if (__mouseEventsHandled) return;
        __mouseEventsHandled = true;

        Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, function (e:MouseEvent) {
            PointerManager.pressed(ownerWidget(e.target));
        });
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, function (e:MouseEvent) {
            PointerManager.released(ownerWidget(e.target));
        });
        //for flash >= 11.3
        if (MouseEvent.RELEASE_OUTSIDE != null) {
            Lib.current.stage.addEventListener(MouseEvent.RELEASE_OUTSIDE, function (e:MouseEvent) {
                PointerManager.released(null);
            });
        }
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, function (e:MouseEvent) {
            PointerManager.moved(ownerWidget(e.target));
        });
    }


    /**
     * Constructor
     */
    public function new () : Void
    {
        handlePointers();
    }


    /**
     * Create backend for simple widget
     */
    public function widgetBackend (widget:Widget) : Backend
    {
        return new Backend(widget);
    }


    /**
     * Create native text renderer for text field
     */
    public function textRenderer (textField:Text) : TextRenderer
    {
        return new TextRenderer(textField);
    }


    /**
     * Create native bitmap renderer for Bmp widget
     */
    public function bitmapRenderer (bmp:Bmp) : BitmapRenderer
    {
        return new BitmapRenderer(bmp);
    }


    /**
     * Find widget which contains specified `object`
     */
    @:access(sx.backend.flash.Backend.widget)
    static private function ownerWidget (object:DisplayObject) : Null<Widget>
    {
        while (object != null) {
            if (untyped __is__(object, Backend)) {
                return cast(object, Backend).widget;
            }
            object = object.parent;
        }

        return null;
    }

}//class BackendManager