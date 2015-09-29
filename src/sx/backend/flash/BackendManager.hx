package sx.backend.flash;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import sx.backend.Backend;
import sx.backend.BitmapRenderer;
import sx.backend.interfaces.IBackendManager;
import sx.backend.TextRenderer;
import sx.widgets.Bmp;
import sx.widgets.Text;
import sx.widgets.Widget;



/**
 * Backend factory implementation
 *
 */
class BackendManager implements IBackendManager
{

    /**
     * Constructor
     */
    public function new () : Void
    {
        __handleMouse();
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
     * Translate mouse flash events to StablexUI signals
     */
    private function __handleMouse () : Void
    {
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, function (e:MouseEvent) {
            var widget = ownerWidget(e.target);
            // if (widget != null) {
            //     widget.onPress.bubbleDispatch(onPress, widget);
            // }
        });
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, function (e:MouseEvent) {
            var widget = ownerWidget(e.target);
            // if (widget != null) {
            //     widget.onRelease.bubbleDispatch(onPress, widget);
            // }
        });
    }


    /**
     * Find widget which contains specified `object`
     */
    @:access(sx.backend.flash.Backend.widget)
    private function ownerWidget (object:DisplayObject) : Null<Widget>
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