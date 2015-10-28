package ;

import flash.events.Event;
import flash.Lib;
import sx.backend.BitmapData;
import sx.groups.RadioGroup;
import sx.layout.LineLayout;
import sx.skins.PaintSkin;
import sx.properties.Align;
import sx.skins.Skin;
import sx.Sx;
import sx.themes.flatui.styles.ButtonStyle;
import sx.themes.flatui.styles.CheckBoxStyle;
import sx.themes.flatui.styles.ProgressBarStyle;
import sx.themes.flatui.styles.RadioStyle;
import sx.themes.flatui.styles.SliderStyle;
import sx.themes.flatui.styles.TextInputStyle;
import sx.themes.FlatUITheme;
import sx.transitions.FadeTransition;
import sx.tween.easing.*;
import sx.widgets.Bmp;
import sx.widgets.Button;
import sx.widgets.CheckBox;
import sx.widgets.HBox;
import sx.widgets.ProgressBar;
import sx.widgets.Radio;
import sx.widgets.TabBar;
import sx.widgets.Text;
import sx.widgets.TextInput;
import sx.widgets.VBox;
import sx.widgets.ViewStack;
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
    /** Tabs to select `viewStack` page */
    static private var menu : TabBar;
    /** View stack to switch components demos */
    static private var viewStack : ViewStack;


    /**
     * Entry point
     */
    static public function main () : Void
    {
        Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
        Lib.current.stage.align     = flash.display.StageAlign.TOP_LEFT;

        // Sx.dipFactor  = 0.6;
        Sx.pixelSnapping = true;
        Sx.theme = new FlatUITheme();
        Sx.init(run);
    }


    /**
     * Run application
     */
    static public function run () : Void
    {
        buildGui();

        var pages = [
            'Buttons'        => buttons(),
            'Toggle Buttons' => toggleButtons(),
            'Text Inputs'    => textInputs(),
            'Progress Bars'  => progressBars(),
            'Sliders'        => sliders(),
            'Checkboxes'     => checkBoxes(),
            'Radio Toggles'  => radios(),
        ];

        //to ensure pages maintain order on each application run.
        var sorted = [for (pageName in pages.keys()) pageName];
        sorted.sort(Reflect.compare);

        for (pageName in sorted) {
            menu.createTab(pageName);

            var page = pages.get(pageName);
            page.name = pageName;
            page.width.pct  = 100;
            page.height.pct = 100;
            page.skin = whiteSkin();
            viewStack.addChild(page);
        }
    }


    /**
     * Create tabs & view stack
     */
    static private function buildGui () : Void
    {
        menu = new TabBar();

        viewStack = new ViewStack();
        viewStack.width.pct  = 100;
        viewStack.height.pct = 100;
        viewStack.transition = new FadeTransition();
        viewStack.transition.duration = 0.2;

        menu.viewStack = viewStack;
        menu.onResize.add(function(_,_,_,_) {
            viewStack.top    = menu.height;
            viewStack.height.pct = 100 * (1 - (menu.height / Sx.root.height));
        });

        Sx.root.addChild(viewStack);
        Sx.root.addChild(menu);
    }


    /**
     * Creates white skin to use as opaque background
     */
    static private function whiteSkin () : Skin
    {
        var skin = new PaintSkin();
        skin.color = 0xFFFFFF;
        skin.corners = 16;

        return skin;
    }


    /**
     * Description
     */
    static public function buttons () : Widget
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

        return box;
    }


    /**
     * Description
     */
    static public function textInputs () : Widget
    {
        var box = new HBox();
        box.gap = 10;
        box.padding = 10;

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

        return box;
    }


    /**
     * Description
     */
    static public function progressBars () : Widget
    {
        function randomValue (p:ProgressBar) return p.min + (0.2 + 0.6 * Math.random()) * (p.max - p.min);

        var box = new VBox();
        box.gap     = 20;
        box.padding = 10;

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

        var randomize = new Button();
        randomize.text = 'Randomize values';
        randomize.onTrigger.add(function(_) {
            var child, bar;
            for (parent in [box, hbox]) {
                for (i in 0...parent.numChildren) {
                    child = parent.getChildAt(i);
                    if (Std.is(child, ProgressBar)) {
                        bar = cast(child, ProgressBar);
                        bar.value = randomValue(bar);
                    }
                }
            }
        });
        box.addChild(randomize);

        return box;
    }


    /**
     * Description
     */
    static public function sliders () : Widget
    {
        function randomValue (p:Slider) return p.min + (0.2 + 0.6 * Math.random()) * (p.max - p.min);

        var box = new VBox();
        box.gap     = 20;
        box.padding = 10;

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

        var randomize = new Button();
        randomize.text = 'Randomize values';
        randomize.onTrigger.add(function(_) {
            var child, slider;
            for (parent in [box, hbox]) {
                for (i in 0...parent.numChildren) {
                    child = parent.getChildAt(i);
                    if (Std.is(child, Slider)) {
                        slider = cast(child, Slider);
                        slider.value = randomValue(slider);
                    }
                }
            }
        });
        box.addChild(randomize);

        return box;
    }


    /**
     * Description
     */
    static public function toggleButtons () : Widget
    {
        var box = new VBox();
        box.padding = 10;
        box.gap = 10;

        var btn = new ToggleButton();
        btn.up.text = 'Default';
        btn.down.text = 'Default selected';
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Warning';
        btn.down.text = 'Warning selected';
        btn.style = ButtonStyle.WARNING;
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Danger';
        btn.down.text = 'Danger selected';
        btn.style = ButtonStyle.DANGER;
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Success';
        btn.down.text = 'Success selected';
        btn.style = ButtonStyle.SUCCESS;
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Inverse';
        btn.down.text = 'Inverse selected';
        btn.style = ButtonStyle.INVERSE;
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Info';
        btn.down.text = 'Info selected';
        btn.style = ButtonStyle.INFO;
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Disabled';
        btn.down.text = 'Disabled selected';
        btn.enabled = false;
        box.addChild(btn);

        return box;
    }


    /**
     * Description
     */
    static public function checkBoxes () : Widget
    {
        var box = new VBox();
        box.gap = 10;
        box.padding = 10;
        box.align = Left & Top;

        var check = new CheckBox();
        check.text = 'Default';
        check.selected = true;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Warning';
        check.style = CheckBoxStyle.WARNING;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Danger';
        check.style = CheckBoxStyle.DANGER;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Success';
        check.selected = true;
        check.style = CheckBoxStyle.SUCCESS;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Inverse';
        check.style = CheckBoxStyle.INVERSE;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Info';
        check.selected = true;
        check.style = CheckBoxStyle.INFO;
        box.addChild(check);

        var container = new VBox();
        container.addChild(box);

        return container;
    }


    /**
     * Description
     */
    static public function radios () : Widget
    {
        var box = new VBox();
        box.gap = 10;
        box.padding = 10;
        box.align = Left & Top;

        var group = new RadioGroup();

        var radio = new Radio();
        radio.text = 'Default';
        radio.selected = true;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Warning';
        radio.style = RadioStyle.WARNING;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Danger';
        radio.style = RadioStyle.DANGER;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Success';
        radio.style = RadioStyle.SUCCESS;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Inverse';
        radio.style = RadioStyle.INVERSE;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Info';
        radio.style = RadioStyle.INFO;
        radio.group = group;
        box.addChild(radio);

        var container = new VBox();
        container.addChild(box);

        return container;
    }

}//class Main