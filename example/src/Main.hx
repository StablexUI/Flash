package ;

import flash.events.Event;
import flash.Lib;
import flash.text.TextFormatAlign;
import sx.backend.BitmapData;
import sx.layout.LineLayout;
import sx.skins.PaintSkin;
import sx.Sx;
import sx.themes.flatui.ButtonStyle;
import sx.themes.flatui.ProgressBarStyle;
import sx.themes.flatui.TextInputStyle;
import sx.themes.FlatUITheme;
import sx.tween.easing.*;
import sx.widgets.Bmp;
import sx.widgets.Button;
import sx.widgets.HBox;
import sx.widgets.ProgressBar;
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
        Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
        Lib.current.stage.align     = flash.display.StageAlign.TOP_LEFT;

        // Sx.dipFactor  = 1.53;
        // Sx.pixelSnapping = true;
        Sx.theme = new FlatUITheme();
        Sx.init(run);
    }


    /**
     * Run application
     */
    static public function run () : Void
    {
        addButtons();
        addTextInputs();
        addProgressBars();
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

        Sx.root.addChild(box);
    }


    /**
     * Description
     */
    static public function addTextInputs () : Void
    {
        var box = new HBox();
        box.gap = 10;
        box.padding = 10;
        box.left = 200;

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

        Sx.root.addChild(box);
    }


    /**
     * Description
     */
    static public function addProgressBars () : Void
    {
        var randomValue = function (p:ProgressBar) return p.min + (0.2 + 0.6 * Math.random()) * (p.max - p.min);

        var box = new VBox();
        box.gap     = 20;
        box.padding = 10;
        box.left    = 200;
        box.top     = 80;

        var progress = new ProgressBar();
        progress.value  = randomValue(progress);
        progress.easing = Quad.easeOut;
        progress.interactive = true;
        box.addChild(progress);

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.WARNING;
        progress.value  = randomValue(progress);
        progress.easing = Quad.easeOut;
        progress.interactive = true;
        box.addChild(progress);

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.CONCRETE;
        progress.value  = randomValue(progress);
        progress.easing = Quad.easeOut;
        progress.interactive = true;
        progress.bar.right.select();
        box.addChild(progress);

        var hbox = new HBox();
        hbox.gap = 30;
        hbox.padding = 10;

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.DANGER_VERTICAL;
        progress.value  = randomValue(progress);
        progress.interactive = true;
        hbox.addChild(progress);

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.SUCCESS_VERTICAL;
        progress.value  = randomValue(progress);
        progress.interactive = true;
        hbox.addChild(progress);

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.INVERSE_VERTICAL;
        progress.value  = randomValue(progress);
        progress.interactive = true;
        progress.bar.top.select();
        hbox.addChild(progress);

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.INFO_VERTICAL;
        progress.value  = randomValue(progress);
        progress.interactive = true;
        progress.bar.top.select();
        hbox.addChild(progress);

        box.addChild(hbox);
        Sx.root.addChild(box);
    }

}//class Main