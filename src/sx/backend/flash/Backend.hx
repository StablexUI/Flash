package sx.backend.flash;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import sx.widgets.Widget;

using sx.tools.WidgetTools;


/**
 * StablexUI backend implementation on top of flash display list.
 *
 */
class Backend extends Sprite
{
    /** Owner of this backend instance */
    private var widget : Widget;

    /** Container for widgets */
    private var widgets : Sprite;
    /** Transformation matrix */
    private var matrix : Matrix;


    /**
     * Constructor
     */
    public function new (widget:Widget) : Void
    {
        super();

        this.widget = widget;

        widgets = new Sprite();
        addChild(widgets);
    }


    /**
     * Add `child` to display list of this widget.
     *
     * Returns added child.
     */
    public inline function addWidget (child:Widget) : Void
    {
        widgets.addChild(child.backend);
    }


    /**
     * Insert `child` at specified `index` of display list of this widget..
     *
     * If `index` is negative, calculate required index from the end of display list (`numChildren` + index).
     * If `index` is out of bounds, `child` will be added to the end (positive `index`) or to the beginning
     * (negative `index`) of display list.
     *
     * Returns added `child`.
     */
    public inline function addWidgetAt (child:Widget, index:Int) : Void
    {
        index = clampIndex(index, true);
        widgets.addChildAt(child.backend, index);
    }


    /**
     * Remove `child` from display list of this widget.
     *
     * Returns removed child.
     * Returns `null` if this widget is not a parent for this `child`.
     */
    public inline function removeWidget (child:Widget) : Void
    {
        if (child.parent == widget) {
            widgets.removeChild(child.backend);
        }
    }


    /**
     * Remove child at `index` of display list of this widget.
     *
     * If `index` is negative, calculate required index from the end of display list (`numChildren` + index).
     *
     * Returns removed child or `null` if `index` is out of bounds.
     */
    public inline function removeWidgetAt (index:Int) : Null<Widget>
    {
        if (index < 0) index += widgets.numChildren;

        if (index >= 0 && index < widgets.numChildren) {
            var removed : Backend = cast widgets.removeChildAt(index);

            return removed.widget;
        } else {
            return null;
        }
    }


    /**
     * Get index of a `child` in a list of children of this widget.
     */
    public inline function getWidgetIndex (child:Widget) : Int
    {
        return widgets.getChildIndex(child.backend);
    }


    /**
     * Move `child` to specified `index` in display list.
     *
     * If `index` is greater then amount of children, `child` will be added to the end of display list.
     * If `index` is negative, required position will be calculated from the end of display list.
     * If `index` is negative and calculated position is less than zero, `child` will be added at the beginning of display list.
     *
     * Returns new position of a `child` in display list.
     */
    public inline function setWidgetIndex (child:Widget, index:Int) : Int
    {
        index = clampIndex(index, false);
        widgets.setChildIndex(child.backend, index);

        return index;
    }


    /**
     * Get child at specified `index`.
     *
     * If `index` is negative, required child is calculated from the end of display list.
     *
     * Returns child located at `index`, or returns `null` if `index` is out of bounds.
     */
    public inline function getWidgetAt (index:Int) : Null<Widget>
    {
        if (index < 0 ) index += widgets.numChildren;

        if (0 <= index && index < widgets.numChildren) {
            var childBackend : Backend = cast widgets.getChildAt(index);

            return childBackend.widget;
        } else {
            return null;
        }
    }


    /**
     * Swap two specified child widgets in display list.
     */
    public inline function swapWidgets (child1:Widget, child2:Widget) : Void
    {
        widgets.swapChildren(child1.backend, child2.backend);
    }


    /**
     * Swap children at specified indexes.
     *
     * Indicies must be positive.
     */
    public inline function swapWidgetsAt (index1:Int, index2:Int) : Void
    {
        widgets.swapChildrenAt(index1, index2);
    }


    /**
     * Convert global point to local point
     */
    public function widgetGlobalToLocal (point:Point) : Point
    {
        return globalToLocal(point);
    }


    /**
     * Convert local point to global point
     */
    public function widgetLocalToGlobal (point:Point) : Point
    {
        return localToGlobal(point);
    }


    /**
     * Called when origin of a widget was changed
     */
    public inline function widgetOriginChanged () : Void
    {
        updateTransform();
    }


    /**
     * Called when offset of a widget was changed
     */
    public inline function widgetOffsetChanged () : Void
    {
        if (widget.hasOrigin()) {
            updateTransform();
        } else {
            x = Sx.snap(widget.left.px + widget.offset.left.px);
            y = Sx.snap(widget.top.px + widget.offset.top.px);
        }
    }


    /**
     * Called when widget width/height is changed.
     */
    public inline function widgetResized () : Void
    {
        if (widget.hasOrigin()) {
            updateTransform();
        }
        updateScrollRect();
    }


    /**
     * Called when widget position is changed.
     */
    public inline function widgetMoved () : Void
    {
        if (widget.hasOrigin()) {
            updateTransform();
        } else {
            if (widget.hasOffset()) {
                x = Sx.snap(widget.left.px + widget.offset.left.px);
                y = Sx.snap(widget.top.px + widget.offset.top.px);
            } else {
                x = Sx.snap(widget.left.px);
                y = Sx.snap(widget.top.px);
            }
        }
    }


    /**
     * Called when widget rotation is changed
     */
    public inline function widgetRotated () : Void
    {
        if (widget.hasOrigin()) {
            updateTransform();
        } else {
            rotation = widget.rotation;
        }
    }


    /**
     * Called when widget.scaleX is changed
     */
    public inline function widgetScaledX () : Void
    {
        if (widget.hasOrigin()) {
            updateTransform();
        } else {
            scaleX = widget.scaleX;
        }
    }


    /**
     * Called when widget.scaleY is changed
     */
    public inline function widgetScaledY () : Void
    {
        if (widget.hasOrigin()) {
            updateTransform();
        } else {
            scaleY = widget.scaleY;
        }
    }


    /**
     * Called when widget.alpha is changed
     */
    public inline function widgetAlphaChanged () : Void
    {
        alpha = widget.alpha;
    }


    /**
     * Called when widget.visible is changed
     */
    public inline function widgetVisibilityChanged () : Void
    {
        visible = widget.visible;
    }


    /**
     * Called when widget.overflow is changed
     */
    public inline function widgetOverflowChanged () : Void
    {
        updateScrollRect();
    }


    /**
     * Called when skin of a widget was changed
     */
    public inline function widgetSkinChanged () : Void
    {

    }


    /**
     * Method to cleanup and release this object for garbage collector.
     */
    public inline function widgetDisposed () : Void
    {
        widget = null;
    }


    /**
     * Convert `index` to positive value between 0 and `numChildren`
     */
    private inline function clampIndex (index:Int, allowOverflow:Bool) : Int
    {
        if (index < 0) {
            index += widgets.numChildren;
            if (index < 0) index = 0;
        } else if (allowOverflow && index > widgets.numChildren) {
            index = widgets.numChildren;
        } else if (!allowOverflow && index >= widgets.numChildren) {
            index = widgets.numChildren - 1;
        }

        return index;
    }


    /**
     * Update transformation matrix
     */
    private inline function updateTransform () : Void
    {
        if (matrix == null) matrix = new Matrix();

        matrix.identity();
        var originX = widget.origin.left.px;
        var originY = widget.origin.top.px;

        matrix.translate(-originX, -originY);
        if (widget.scaleX != 1 || widget.scaleY != 1) {
            matrix.scale(widget.scaleX, widget.scaleY);
        }
        if (widget.rotation != 0) {
            matrix.rotate(widget.rotation * Math.PI / 180);
        }
        matrix.translate(originX, originY);

        matrix.translate(widget.left.px, widget.top.px);
        if (widget.hasOffset()) {
            matrix.translate(widget.offset.left.px, widget.offset.top.px);
        }

        matrix.tx = Sx.snap(matrix.tx);
        matrix.ty = Sx.snap(matrix.ty);

        transform.matrix = matrix;
    }


    /**
     * Update `scrollRect` according to `widget.overflow`
     */
    private inline function updateScrollRect () : Void
    {
        if (widget.overflow) {
            scrollRect = null;
        } else {
            var rect = scrollRect;
            if (rect == null) rect = new Rectangle();
            rect.x = 0;
            rect.y = 0;
            rect.width = widget.width.px;
            rect.height = widget.height.px;

            scrollRect = rect;
        }
    }


    /**
     * Add skin's display object
     */
    @:allow(sx.backend.flash)
    private inline function setSkinObject (object:DisplayObject) : Void
    {
        addChildAt(object, 0);
    }


    /**
     * Add renderer's display object
     */
    @:allow(sx.backend.flash)
    private inline function addRendererObject (object:DisplayObject) : Void
    {
        addChildAt(object, getChildIndex(widgets));
    }


}//class Backend