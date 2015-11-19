package sx.backend.flash;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import sx.backend.Backend;
import sx.backend.BitmapRenderer;
import sx.backend.interfaces.IBackendManager;
import sx.backend.Point;
import sx.backend.TextInputRenderer;
import sx.backend.TextRenderer;
import sx.input.Pointer;
import sx.tween.Tweener;
import sx.widgets.Bmp;
import sx.widgets.Text;
import sx.widgets.TextInput;
import sx.widgets.Widget;



/**
 * Backend factory implementation
 *
 */
class BackendManager implements IBackendManager
{
    /** If mouse events listeners attached to stage */
    static private var __mouseEventsHandled : Bool = false;
    /** If ENTER_FRAME is already set up */
    static private var __framesHandled : Bool = false;
    /** Widget for `sx.Sx.root` */
    static private var __root : Widget;


    /**
     * Translate flash mouse & touch events to StablexUI signals
     */
    static private function __handlePointers () : Void
    {
        if (__mouseEventsHandled) return;
        __mouseEventsHandled = true;

        Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, function (e:MouseEvent) {
            Pointer.pressed(__ownerWidget(e.target));
        });
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, function (e:MouseEvent) {
            Pointer.released(__ownerWidget(e.target));
        });
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, function (e:MouseEvent) {
            Pointer.moved(__ownerWidget(e.target));
        });
        //openfl and nme does not support RELEASE_OUTSIDE
        #if flash
            //for flash >= 11.3
            if (MouseEvent.RELEASE_OUTSIDE != null) {
                Lib.current.stage.addEventListener(MouseEvent.RELEASE_OUTSIDE, function (e:MouseEvent) {
                    Pointer.released(null);
                });
            }
        #end
    }


    /**
     * Setup ENTER_FRAME handler
     */
    static private function __handleFrames () : Void
    {
        if (__framesHandled) return;
        __framesHandled = true;

        Lib.current.stage.addEventListener(Event.ENTER_FRAME, function(_) {
            Sx.frame();
        });
    }


    /**
     * Create root widget
     */
    static private function __setupRoot () : Void
    {
        if (__root != null) return;

        var stage = Lib.current.stage;

        __root = new Widget();
        __root.width.px = stage.stageWidth;
        __root.height.px = stage.stageHeight;

        Lib.current.addChild(__root.backend);
        __root.initialize();

        //adjust root size according to stage size
        stage.addEventListener(Event.RESIZE, function(_) {
            __root.width.px  = stage.stageWidth;
            __root.height.px = stage.stageHeight;
        });
    }


    /**
     * Constructor
     */
    public function new () : Void
    {

    }


    /**
     * Map mouse/touch events to StablexUI signals
     */
    public function setupPointerDevices () : Void
    {
        __handlePointers();
    }


    /**
     * Start calling `Sx.frame()` on each frame.
     */
    public function setupFrames () : Void
    {
        __handleFrames();
    }


    /**
     * Return widget which will be used for `sx.Sx.root`
     */
    public function getRoot () : Widget
    {
        if (__root == null) __setupRoot();

        return __root;
    }


    /**
     * Get pointer global position (mouse cursor or touch with specified `touchId`).
     *
     * If `touchId` is less or equal to `0` it should return mouse position or first touch position.
     */
    public function getPointerPosition (touchId:Int = 0) : Point
    {
        return new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
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
     * Create native input text renderer
     */
    public function textInputRenderer (textInput:TextInput) : TextInputRenderer
    {
        return new TextInputRenderer(textInput);
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
    static private function __ownerWidget (object:DisplayObject) : Null<Widget>
    {
        while (object != null) {
            if (Std.is(object, Backend)) {
                return cast(object, Backend).widget;
            }
            object = object.parent;
        }

        return null;
    }

}//class BackendManager