package sx.backend.flash;

import hunit.TestCase;
import sx.widgets.Text;



/**
 * sx.backend.flash.TextRenderer
 *
 */
class TextRendererTest extends TestCase
{

    @test
    public function wordWrap_setTextWidgetAutoSizeWidthTrue_setWordWrapTrue () : Void
    {
        var label = new Text();
        label.renderer.wordWrap = false;

        label.autoSize.width = true;

        assert.isTrue(label.renderer.wordWrap);
    }


    @test
    public function wordWrap_setTextWidgetAutoSizeWidthFalse_setWordWrapFalse () : Void
    {
        var label = new Text();
        label.renderer.wordWrap = true;

        label.autoSize.width = false;

        assert.isFalse(label.renderer.wordWrap);
    }


    @test
    public function wordWrap_setTextWidgetWidthDirectly_setWordWrapFalse () : Void
    {
        var label = new Text();
        label.renderer.wordWrap = true;

        label.width.dip = 100;

        assert.isFalse(label.renderer.wordWrap);
    }

}//class TextRendererTest