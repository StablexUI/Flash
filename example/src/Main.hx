package ;

import flash.events.Event;
import flash.Lib;
import flash.text.TextFormatAlign;
import sx.backend.BitmapData;
import sx.layout.LineLayout;
import sx.skins.PaintSkin;
import sx.Sx;
import sx.themes.flatui.ButtonStyle;
import sx.themes.flatui.TextInputStyle;
import sx.themes.FlatUITheme;
import sx.widgets.Bmp;
import sx.widgets.Button;
import sx.widgets.HBox;
import sx.widgets.Text;
import sx.widgets.TextInput;
import sx.widgets.VBox;
import sx.widgets.Widget;

using Std;


/**
 * Flash backend example
 *
 */
class Main
{
    /** Widget used as root to not bother about other widgets initialization. */
    static private var root : Widget;


    /**
     * Entry point
     */
    static public function main () : Void
    {
        Sx.dipFactor = 1;
        Sx.theme = new FlatUITheme();
        Sx.init(run);
    }


    /**
     * Run application
     */
    static public function run () : Void
    {
        initRoot();

        var btn = new Button();
        btn.text = 'Hello';
        btn.top = 50;

        var t = new sx.tween.Tweener();
        t.tween(btn.left, 'dip', 500, 1);
        t.tween(btn.top, 'dip', 500, 1);

        Lib.current.addEventListener(Event.ENTER_FRAME, function(_) {
            sx.tween.Tweener.update();
        });
        root.addChild(btn);

        // addButtons();
        // addTextInputs();
    }


    /**
     * Create root widget and handle stage resizings
     */
    static public function initRoot () : Void
    {
        var stage = Lib.current.stage;

        stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
        stage.align     = flash.display.StageAlign.TOP_LEFT;

        root = new Widget();
        root.width.px = stage.stageWidth;
        root.height.px = stage.stageHeight;

        stage.addChild(root.backend);
        root.initialize();

        //adjust root size according to stage size
        stage.addEventListener(Event.RESIZE, function(_) {
            root.width.px = stage.stageWidth;
            root.height.px = stage.stageHeight;
        });
    }


    /**
     * Description
     */
    static public function addButtons () : Void
    {
        var box = new VBox();
        box.gap = 10;
        box.padding = 10;

        var btn = new Button();
        btn.text = 'Default Button';
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Warning Button';
        btn.style = ButtonStyle.WARNING;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Concrete Button';
        btn.style = ButtonStyle.CONCRETE;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Danger Button';
        btn.style = ButtonStyle.DANGER;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Success Button';
        btn.style = ButtonStyle.SUCCESS;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Inverse Button';
        btn.style = ButtonStyle.INVERSE;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Info Button';
        btn.style = ButtonStyle.INFO;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Disabled Button';
        btn.style = ButtonStyle.DISABLED;
        box.addChild(btn);

        root.addChild(box);
    }


    /**
     * Description
     */
    static public function addTextInputs () : Void
    {
        var box = new HBox();
        box.gap = 10;
        box.padding = 10;
        box.left = 250;

        var input = new TextInput();
        input.invitation = 'Default Input';
        box.addChild(input);

        var input = new TextInput();
        input.style = TextInputStyle.SUCCESS;
        input.invitation = 'Success Input';
        box.addChild(input);

        var input = new TextInput();
        input.style = TextInputStyle.ERROR;
        input.invitation = 'Error Input';
        box.addChild(input);

        root.addChild(box);
    }


}//class Main