package sx.backend.flash;

import hunit.TestCase;
import sx.backend.Backend;
import sx.skins.Skin;
import sx.widgets.Widget;



/**
 * sx.backend.flash.Backend
 *
 */
class BackendTest extends TestCase
{

    @test
    public function widgetResized_widgetHasSkin_invokesSkinRefresh () : Void
    {
        var widget  = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        stub(backend).widgetSkinChanged();
        var skin = mock(Skin).create();
        widget.skin = skin;

        expect(skin).refresh().once();

        backend.widgetResized();
    }


    @test
    public function widgetSkinChanged_widgetSetSkin_invokesSkinRefresh () : Void
    {
        var widget = new Widget();
        var skin   = mock(Skin).create();

        expect(skin).refresh().once();

        widget.skin = skin;
    }


    @test
    public function widgetSkinChanged_widgetHasSkin_invokesSkinRefresh () : Void
    {
        var widget = new Widget();
        var skin   = mock(Skin).create();
        widget.skin = skin;

        expect(skin).refresh().once();

        widget.backend.widgetSkinChanged();
    }

}//class BackendTest