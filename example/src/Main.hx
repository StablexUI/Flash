package ;

import flash.events.Event;
import flash.Lib;
import flash.text.TextFormatAlign;
import sx.backend.BitmapData;
import sx.layout.LineLayout;
import sx.skins.PaintSkin;
import sx.widgets.Bmp;
import sx.widgets.Button;
import sx.widgets.HBox;
import sx.widgets.Text;
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
        initRoot();

        var parent = new Widget();
        parent.left = 200;
        parent.top  = 200;
        parent.width = 100;
        parent.height = 30;
        parent.origin.set(1, 0.5);
        parent.skin = skin();

        var child = parent.addChild(new Widget());
        child.left = 50;
        child.bottom = -15;
        child.width.pct = 100;
        child.height.pct = 100;
        child.skin = skin();

        root.addChild(parent);

        //left aligned text
        var label1 = new Text();
        label1.text      = 'Left aligned';
        label1.left  = 10;
        label1.top   = 10;
        label1.width = 100;
        label1.skin      = skin();
        var format = label1.getTextFormat();
        format.align = TextFormatAlign.LEFT;
        label1.setTextFormat(format);
        root.addChild(label1);

        //center aligned text
        var label2 = new Text();
        label2.text      = 'Center aligned';
        label2.left  = 150;
        label2.top   = 10;
        label2.width = 100;
        label2.skin      = skin();
        var format = label2.getTextFormat();
        format.align = TextFormatAlign.CENTER;
        label2.setTextFormat(format);
        root.addChild(label2);

        //right aligned text
        var label3 = new Text();
        label3.text      = 'Right aligned';
        label3.left  = 300;
        label3.top   = 10;
        label3.width = 100;
        label3.skin      = skin();
        var format = label3.getTextFormat();
        format.align = TextFormatAlign.RIGHT;
        label3.setTextFormat(format);
        root.addChild(label3);

        var bmp = new Bmp();
        var data = new BitmapData(100, 50);
        data.perlinNoise(100, 80, 6, Math.floor(Math.random() * 10), false, true);
        bmp.bitmapData = data;
        bmp.left    = 500;
        bmp.top     = 400;
        bmp.padding = 10;
        bmp.skin = skin();
        bmp.keepAspect = false;
        root.addChild(bmp);

        var a = 0.;
        var labelWidth = 0.;
        Lib.current.addEventListener(Event.ENTER_FRAME, function(_){
            label1.width = 100 + 25 * Math.sin(a);
            label2.width = 100 + 25 * Math.cos(a);
            label3.width = 100 + 25 * Math.sin(a);

            bmp.width  = 100 + 25 * Math.cos(a);
            bmp.height = 50 + 25 * Math.sin(a);

            parent.rotation += 0.2;
            parent.width = 100 + 20 * Math.sin(a);
            parent.scaleY = 1 + 0.5 * Math.cos(a);

            child.alpha = 0.5 + 0.5 * Math.sin(2 * a);

            cast(parent.skin, PaintSkin).alpha = 0.5 + 0.5 * Math.sin(4 * a);

            a += 0.02;
        });

        var btn = new Button();
        btn.ico = new Widget();
        btn.ico.width  = 10;
        btn.ico.height = 10;
        btn.ico.skin = skin();
        btn.text = 'I am a button!';
        btn.skin = skin();
        btn.right.pct = 100;
        btn.bottom.pct = 100;

        bmp.addChild(btn);

        btn.down.text = 'Pressed!';
        btn.down.skin = skin();
        btn.hover.text = 'Hovered!';
        btn.hover.skin = skin();

        var layout : LineLayout = cast btn.layout;
        layout.padding.horizontal = 10;
        btn.layout = layout;

        btn.onPointerTap.add(function (p, d, i) {
            trace('click!');
        });
        btn.onTrigger.add(function(b) {
            trace('trigger!');
        });

        var box = new VBox();
        box.padding = 10;
        box.gap = 5;
        box.skin = skin();
        for (i in 0...5){
            var w = box.addChild(new Widget());
            w.width = (70 + 60 * Math.random()).int();
            w.height = (30 + 20 * Math.random()).int();
            w.skin = skin();
        }
        root.addChild(box);
        box.left = 10;
        box.top  = 300;

        var box = new HBox();
        box.padding = 10;
        box.gap = 5;
        box.skin = skin();
        for (i in 0...5){
            var w = box.addChild(new Widget());
            w.width = (50 + 30 * Math.random()).int();
            w.height = (20 + 10 * Math.random()).int();
            w.skin = skin();
        }
        root.addChild(box);
        box.left = 200;
        box.top  = 500;
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
        Lib.current.addEventListener(Event.RESIZE, function(_) {
            root.width.px = stage.stageWidth;
            root.height.px = stage.stageHeight;
        });
    }


    /**
     * Create PaintSkin with specified or random color
     */
    static public function skin (color:Int = -1) : PaintSkin
    {
        var skin = new PaintSkin();
        skin.color = (color < 0 ? Std.random(0xFFFFFF) : color);

        return skin;
    }

}//class Main