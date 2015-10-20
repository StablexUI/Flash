package ;

import flash.events.Event;
import flash.Lib;
import sx.backend.BitmapData;
import sx.layout.LineLayout;
import sx.skins.PaintSkin;
import sx.properties.Align;
import sx.Sx;
import sx.themes.flatui.styles.ButtonStyle;
import sx.themes.flatui.styles.CheckboxStyle;
import sx.themes.flatui.styles.ProgressBarStyle;
import sx.themes.flatui.styles.RadioStyle;
import sx.themes.flatui.styles.SliderStyle;
import sx.themes.flatui.styles.TextInputStyle;
import sx.themes.FlatUITheme;
import sx.tween.easing.*;
import sx.widgets.Bmp;
import sx.widgets.Button;
import sx.widgets.Checkbox;
import sx.widgets.HBox;
import sx.widgets.ProgressBar;
import sx.widgets.Text;
import sx.widgets.TextInput;
import sx.widgets.VBox;
import sx.widgets.Widget;
import sx.widgets.Slider;
import sx.widgets.ToggleButton;

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

        // Sx.dipFactor  = 0.4;
        // Sx.pixelSnapping = true;
        Sx.theme = new FlatUITheme();
        Sx.init(run);
    }


    /**
     * Run application
     */
    static public function run () : Void
    {
        // addToggleButtons();
        // addButtons();
        // addTextInputs();
        // addProgressBars();
        // addSliders();
        // addCheckboxes();
        addRadios();
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
        btn.enabled = false;
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
        function randomValue (p:ProgressBar) return p.min + (0.2 + 0.6 * Math.random()) * (p.max - p.min);

        var box = new VBox();
        box.gap     = 20;
        box.padding = 10;
        box.left    = 200;
        box.top     = 80;

        var progress = new ProgressBar();
        progress.value  = randomValue(progress);
        progress.interactive = true;
        box.addChild(progress);

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.WARNING;
        progress.value  = randomValue(progress);
        progress.interactive = true;
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


    /**
     * Description
     */
    static public function addSliders () : Void
    {
        function randomValue (p:Slider) return p.min + (0.2 + 0.6 * Math.random()) * (p.max - p.min);

        var box = new VBox();
        box.gap     = 20;
        box.padding = 10;
        box.left    = 400;
        box.top     = 80;

        var slider = new Slider();
        slider.value  = randomValue(slider);
        box.addChild(slider);

        var slider = new Slider();
        slider.style  = SliderStyle.WARNING;
        slider.value  = randomValue(slider);
        box.addChild(slider);

        var hbox = new HBox();
        hbox.gap = 30;
        hbox.padding = 10;

        var slider = new Slider();
        slider.style  = SliderStyle.DANGER_VERTICAL;
        slider.value  = randomValue(slider);
        hbox.addChild(slider);

        var slider = new Slider();
        slider.style  = SliderStyle.SUCCESS_VERTICAL;
        slider.value  = randomValue(slider);
        hbox.addChild(slider);

        var slider = new Slider();
        slider.style  = SliderStyle.INVERSE_VERTICAL;
        slider.value  = randomValue(slider);
        slider.thumb.top.select();
        hbox.addChild(slider);

        var slider = new Slider();
        slider.style  = SliderStyle.INFO_VERTICAL;
        slider.value  = randomValue(slider);
        slider.thumb.top.select();
        hbox.addChild(slider);

        box.addChild(hbox);
        Sx.root.addChild(box);
    }


    /**
     * Description
     */
    static public function addToggleButtons () : Void
    {
        var box = new VBox();
        box.padding = 10;
        box.bottom = 10;
        box.offset.set(-0.5, 0);
        box.left.pct = 50;

        var hbox1 = new HBox();
        hbox1.padding = 5;
        hbox1.gap = 10;

        var hbox2 = new HBox();
        hbox2.padding = 5;
        hbox2.gap = 10;

        var btn = new ToggleButton();
        btn.up.text = 'Default';
        btn.down.text = 'Default selected';
        hbox1.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Warning';
        btn.down.text = 'Warning selected';
        btn.style = ButtonStyle.WARNING;
        hbox1.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Danger';
        btn.down.text = 'Danger selected';
        btn.style = ButtonStyle.DANGER;
        hbox2.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Success';
        btn.down.text = 'Success selected';
        btn.style = ButtonStyle.SUCCESS;
        hbox2.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Inverse';
        btn.down.text = 'Inverse selected';
        btn.style = ButtonStyle.INVERSE;
        hbox2.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Info';
        btn.down.text = 'Info selected';
        btn.style = ButtonStyle.INFO;
        hbox2.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Disabled';
        btn.down.text = 'Disabled selected';
        btn.enabled = false;
        hbox2.addChild(btn);

        box.addChild(hbox1);
        box.addChild(hbox2);
        Sx.root.addChild(box);
    }


    /**
     * Description
     */
    static public function addCheckboxes () : Void
    {
        var box = new VBox();
        box.gap = 10;
        box.padding = 10;
        box.left = 600;
        box.align = Left & Top;
        box.top = 80;

        var check = new Checkbox();
        check.text = 'Default';
        check.selected = true;
        box.addChild(check);

        var check = new Checkbox();
        check.text = 'Warning';
        check.style = CheckboxStyle.WARNING;
        box.addChild(check);

        var check = new Checkbox();
        check.text = 'Danger';
        check.style = CheckboxStyle.DANGER;
        box.addChild(check);

        var check = new Checkbox();
        check.text = 'Success';
        check.selected = true;
        check.style = CheckboxStyle.SUCCESS;
        box.addChild(check);

        var check = new Checkbox();
        check.text = 'Inverse';
        check.style = CheckboxStyle.INVERSE;
        box.addChild(check);

        var check = new Checkbox();
        check.text = 'Info';
        check.selected = true;
        check.style = CheckboxStyle.INFO;
        box.addChild(check);

        Sx.root.addChild(box);
    }


    /**
     * Description
     */
    static public function addRadios () : Void
    {
        var box = new VBox();
        box.gap = 10;
        box.padding = 10;
        box.left = 80;//750;
        box.align = Left & Top;
        box.top = 80;

        var check = new Radio();
        check.text = 'Default';
        check.selected = true;
        box.addChild(check);

        var check = new Radio();
        check.text = 'Warning';
        check.style = RadioStyle.WARNING;
        box.addChild(check);

        var check = new Radio();
        check.text = 'Danger';
        check.style = RadioStyle.DANGER;
        box.addChild(check);

        var check = new Radio();
        check.text = 'Success';
        check.style = RadioStyle.SUCCESS;
        box.addChild(check);

        var check = new Radio();
        check.text = 'Inverse';
        check.style = RadioStyle.INVERSE;
        box.addChild(check);

        var check = new Radio();
        check.text = 'Info';
        check.style = RadioStyle.INFO;
        box.addChild(check);

        Sx.root.addChild(box);
    }

}//class Main