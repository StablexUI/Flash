package ;

import flash.events.Event;
import flash.Lib;
import flash.text.TextFormatAlign;
import sx.backend.BitmapData;
import sx.skins.PaintSkin;
import sx.widgets.Bmp;
import sx.widgets.Text;
import sx.widgets.Widget;


/**
 * Flash backend example
 *
 */
class Main
{

    /**
     * Entry point
     */
    static public function main () : Void
    {
        Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
        Lib.current.stage.align     = flash.display.StageAlign.TOP_LEFT;

        var root = new Widget();
        root.left.px = 200;
        root.top.px  = 200;
        root.width.px  = 100;
        root.height.px = 30;
        root.origin.set(1, 0.5);
        root.skin = skin(Std.random(0xFFFFFF));

        var child = root.addChild(new Widget());
        child.left.px = 50;
        child.bottom.px = -15;
        child.width.pct = 100;
        child.height.pct = 100;
        child.skin = skin(Std.random(0xFFFFFF));

        Lib.current.addChild(root.backend);


        //left aligned text
        var label1 = new Text();
        label1.text      = 'Left aligned';
        label1.left.dip  = 10;
        label1.top.dip   = 10;
        label1.width.dip = 100;
        label1.skin      = skin(Std.random(0xFFFFFF));
        var format = label1.getTextFormat();
        format.align = TextFormatAlign.LEFT;
        label1.setTextFormat(format);
        Lib.current.addChild(label1.backend);

        //center aligned text
        var label2 = new Text();
        label2.text      = 'Center aligned';
        label2.left.dip  = 150;
        label2.top.dip   = 10;
        label2.width.dip = 100;
        label2.skin      = skin(Std.random(0xFFFFFF));
        var format = label2.getTextFormat();
        format.align = TextFormatAlign.CENTER;
        label2.setTextFormat(format);
        Lib.current.addChild(label2.backend);

        //right aligned text
        var label3 = new Text();
        label3.text      = 'Right aligned';
        label3.left.dip  = 300;
        label3.top.dip   = 10;
        label3.width.dip = 100;
        label3.skin      = skin(Std.random(0xFFFFFF));
        var format = label3.getTextFormat();
        format.align = TextFormatAlign.RIGHT;
        label3.setTextFormat(format);
        Lib.current.addChild(label3.backend);

        var bmp = new Bmp();
        var data = new BitmapData(100, 50);
        data.perlinNoise(100, 80, 6, Math.floor(Math.random() * 10), false, true);
        bmp.bitmapData = data;
        bmp.left.px    = 500;
        bmp.top.px     = 400;
        bmp.padding.px = 10;
        bmp.skin = skin(Std.random(0xFFFFFF));
        bmp.keepAspect = false;
        Lib.current.addChild(bmp.backend);

        var a = 0.;
        var labelWidth = 0.;
        Lib.current.addEventListener(Event.ENTER_FRAME, function(_){
            label1.width.px = 100 + 25 * Math.sin(a);
            label2.width.px = 100 + 25 * Math.cos(a);
            label3.width.px = 100 + 25 * Math.sin(a);

            bmp.width.px  = 100 + 25 * Math.cos(a);
            bmp.height.px = 50 + 25 * Math.sin(a);

            root.rotation += 0.2;
            root.width.px = 100 + 20 * Math.sin(a);
            root.scaleY = 1 + 0.5 * Math.cos(a);

            child.alpha = 0.5 + 0.5 * Math.sin(2 * a);

            cast(root.skin, PaintSkin).alpha = 0.5 + 0.5 * Math.sin(4 * a);

            a += 0.02;
        });
    }


    /**
     * Create PaintSkin with specified color
     */
    static public function skin (color:Int) : PaintSkin
    {
        var skin = new PaintSkin();
        skin.color = color;

        return skin;
    }

}//class Main