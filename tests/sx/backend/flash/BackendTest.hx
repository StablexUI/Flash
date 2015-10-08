package sx.backend.flash;

import hunit.TestCase;
import sx.widgets.Widget;



/**
 * sx.backend.flash.Backend
 *
 */
class BackendTest extends TestCase
{

    @test
    public function offset_widgetHasOffset_backendShifted () : Void
    {
        var widget = new Widget();
        widget.left.px = 10;
        widget.top.px  = 20;
        widget.initialize();

        widget.offset.left.px = 5;
        widget.offset.top.px  = 15;

        assert.equal(15., widget.backend.x);
        assert.equal(35., widget.backend.y);
    }

}//class BackendTest