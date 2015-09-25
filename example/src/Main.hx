package ;

import flash.events.Event;
import flash.Lib;
import sx.skins.PaintSkin;
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

        // // root.rotation = 45;
        root.scaleX = 1.5;
        // // root.scaleY = Math.cos(a);

        var a = 0.;
        Lib.current.addEventListener(Event.ENTER_FRAME, function(_){
            // root.left.px += 0.1;
            // root.top.px += 0.1;

            root.rotation += 0.2;
            root.width.px = 100 + 20 * Math.sin(a);
            // root.scaleX = 1 + Math.sin(a);
            root.scaleY = 1 + 0.5 * Math.cos(a);

            child.alpha = 0.5 + 0.5 * Math.sin(2 * a);

            cast(root.skin, PaintSkin).alpha = 0.5 + 0.5 * Math.sin(4 * a);

            a += 0.02;
        });

        var label = new Text();
        label.text     = 'Hello, world!';
        label.left.dip = 10;
        label.top.dip  = 10;
        label.width.dip = 50;
        Lib.current.addChild(label.backend);
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