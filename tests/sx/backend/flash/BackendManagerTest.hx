package sx.backend.flash;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.Lib;
import hunit.TestCase;
import sx.backend.flash.BackendManager;
import sx.widgets.Widget;



/**
 * sx.backend.flash.BackendManager
 *
 */
class BackendManagerTest extends TestCase
{

    @test
    public function handlePointers_mouseMoved_invokesPointerManagerMoved () : Void
    {
        var invoked = false;
        var widget = new Widget();
        Lib.current.addChild(widget.backend);
        var sprite = widget.backend.addChild(new Sprite());
        widget.onPointerMove.add(function(_,d) invoked = (d == widget));

        sprite.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE, true));

        assert.isTrue(invoked);
    }


    @test
    public function handlePointers_mouseButtonDown_invokesPointerManagerPressed () : Void
    {
        var invoked = false;
        var widget = new Widget();
        Lib.current.addChild(widget.backend);
        var sprite = widget.backend.addChild(new Sprite());
        widget.onPointerPress.add(function(_,d) invoked = (d == widget));

        sprite.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true));

        assert.isTrue(invoked);
    }


    @test
    public function handlePointers_mouseButtonUp_invokesPointerManagerPressed () : Void
    {
        var invoked = false;
        var widget = new Widget();
        Lib.current.addChild(widget.backend);
        var sprite = widget.backend.addChild(new Sprite());
        widget.onPointerRelease.add(function(_,d) invoked = (d == widget));

        sprite.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true));

        assert.isTrue(invoked);
    }

}//class BackendManagerTest