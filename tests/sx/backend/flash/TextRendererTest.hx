package sx.backend.flash;

import flash.text.TextFormatAlign;
import sx.TestCase;
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
        label.autoSize = false;
        label.renderer.wordWrap = true;

        label.autoSize.width = true;

        assert.isFalse(label.renderer.wordWrap);
    }


    @test
    public function wordWrap_setTextWidgetAutoSizeWidthFalse_setWordWrapFalse () : Void
    {
        var label = new Text();
        label.renderer.wordWrap = false;

        label.autoSize.width = false;

        assert.isTrue(label.renderer.wordWrap);
    }


    @test
    public function wordWrap_setTextWidgetWidthDirectly_setWordWrapFalse () : Void
    {
        var label = new Text();
        label.renderer.wordWrap = false;

        label.width.dip = 100;

        assert.isTrue(label.renderer.wordWrap);
    }


    @test
    public function formatAlign_left_positionByLeftBorder () : Void
    {
        var label = new Text();
        label.padding.top.px  = 10;
        label.padding.left.px = 20;
        label.width.px        = 100;
        label.text            = 'hello';
        var format   = label.getTextFormat();
        format.align = TextFormatAlign.LEFT;

        label.setTextFormat(format);

        assert.equal(20., label.renderer.x);
        assert.equal(10., label.renderer.y);
    }


    @test
    public function formatAlign_right_positionByRightBorder () : Void
    {
        var label = new Text();
        label.padding.top.px   = 20;
        label.padding.right.px = 30;
        label.width.px         = 100;
        label.text             = 'hello';
        var format   = label.getTextFormat();
        format.align = TextFormatAlign.RIGHT;

        label.setTextFormat(format);

        var expectedX = label.width.px - label.padding.right.px - label.renderer.getWidth();
        var expectedY = label.padding.top.px;
        assert.equal(expectedX, label.renderer.x);
        assert.equal(expectedY, label.renderer.y);
    }


    @test
    public function formatAlign_center_positionByCenter () : Void
    {
        var label = new Text();
        label.padding.top.px   = 20;
        label.width.px         = 100;
        label.text             = 'hello';
        var format   = label.getTextFormat();
        format.align = TextFormatAlign.CENTER;

        label.setTextFormat(format);

        var expectedX = Math.round((label.width.px - label.renderer.getWidth()) * 0.5);
        var expectedY = label.padding.top.px;
        assert.equal(expectedX, Math.round(label.renderer.x));
        assert.equal(expectedY, label.renderer.y);
    }

}//class TextRendererTest