package sx.backend.flash;

import flash.display.Sprite;
import flash.geom.Matrix;
import sx.exceptions.OutOfBoundsException;
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
    /** Parent widget */
    private var wparent (default,set) : Widget;
    /** Whether widget origin point settings should be used */
    private var useOrigin : Bool = false;

    /** Container to attach skins */
    private var skins : Sprite;
    /** Container for widgets */
    private var widgets : Sprite;
    /** Transformation matrix */
    private var matrix : Matrix;

    /** Debug skin */
    private var tmpSkin : Sprite;


    /**
     * Constructor
     */
    public function new (widget:Widget) : Void
    {
        super();

        this.widget = widget;
        skins = new Sprite();
        addChild(skins);
        widgets = new Sprite();
        addChild(widgets);


        tmpSkin = new Sprite();
        skins.addChild(tmpSkin);

        tmpSkin.graphics.beginFill(Std.random(0xFFFFFF));
        tmpSkin.graphics.drawRect(0, 0, 1, 1);
        tmpSkin.graphics.endFill();
    }


    /**
     * Get parent widget
     */
    public inline function getParentWidget () : Null<Widget>
    {
        return wparent;
    }


    /**
     * Get amount of child widgets in display list of current widget
     */
    public inline function getNumWidgets () : Int
    {
        return widgets.numChildren;
    }


    /**
     * Add `child` to display list of this widget.
     *
     * Returns added child.
     */
    public inline function addWidget (child:Widget) : Widget
    {
        widgets.addChild(child.backend);
        child.backend.wparent = widget;

        return child;
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
    public inline function addWidgetAt (child:Widget, index:Int) : Widget
    {
        index = clampIndex(index, true);
        widgets.addChildAt(child.backend, index);
        child.backend.wparent = widget;

        return child;
    }


    /**
     * Remove `child` from display list of this widget.
     *
     * Returns removed child.
     * Returns `null` if this widget is not a parent for this `child`.
     */
    public inline function removeWidget (child:Widget) : Null<Widget>
    {
        if (child.backend.wparent == widget) {
            widgets.removeChild(child.backend);
            child.backend.wparent = null;

            return child;
        } else {
            return null;
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
            removed.wparent = null;

            return removed.widget;
        } else {
            return null;
        }
    }


    /**
     * Remove all children from child with `beginIndex` position to child with `endIndex` (including).
     *
     * If index is negative, find required child from the end of display list.
     *
     * Returns amount of removed widgets.
     */
    public inline function removeWidgets (beginIndex:Int = 0, endIndex:Int = -1) : Int
    {
        beginIndex = clampIndex(beginIndex, false);
        endIndex   = clampIndex(endIndex, false);

        if (0 <= beginIndex && beginIndex <= endIndex) {
            var removed : Backend;
            for (i in beginIndex...(endIndex + 1)) {
                removed = cast widgets.removeChildAt(beginIndex);
                removed.wparent = null;
            }

            return endIndex - beginIndex + 1;
        } else {
            return 0;
        }
    }


    /**
     * Get index of a `child` in a list of children of this widget.
     *
     * @throws sx.exceptions.NotChildException If `child` is not direct child of this widget.
     */
    public inline function getWidgetIndex (child:Widget) : Int
    {
        if (child.backend.wparent != widget) {
            throw new sx.exceptions.NotChildException();
        }

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
     *
     * @throws sx.exceptions.NotChildException If `child` is not direct child of this widget.
     */
    public inline function setWidgetIndex (child:Widget, index:Int) : Int
    {
        if (child.backend.wparent != widget) {
            throw new sx.exceptions.NotChildException();
        }

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
     *
     * @throws sx.exceptions.NotChildException() If eighter `child1` or `child2` are not a child of this widget.
     */
    public inline function swapWidgets (child1:Widget, child2:Widget) : Void
    {
        if (child1.backend.wparent != widget || child2.backend.wparent != widget) {
            throw new sx.exceptions.NotChildException();
        }

        widgets.swapChildren(child1.backend, child2.backend);
    }


    /**
     * Swap children at specified indexes.
     *
     * If indices are negative, required children are calculated from the end of display list.
     *
     * @throws sx.exceptions.OutOfBoundsException
     */
    public inline function swapWidgetsAt (index1:Int, index2:Int) : Void
    {
        if (index1 < 0) index1 += widgets.numChildren;
        if (index2 < 0) index2 += widgets.numChildren;

        if (index1 < 0 || index1 >= widgets.numChildren || index2 < 0 || index2 > widgets.numChildren) {
            throw new OutOfBoundsException('Provided index does not exist in display list of this widget.');
        }

        widgets.swapChildrenAt(index1, index2);
    }


    /**
     * Called when origin of a widget was changed
     */
    public inline function widgetOriginChanged () : Void
    {
        useOrigin = true;
        updateTransform();
    }


    /**
     * Called when widget width/height is changed.
     */
    public inline function widgetResized () : Void
    {
        // graphics.clear();
        // graphics.beginFill(tmpColor);
        // graphics.drawRect(0, 0, widget.width.px, widget.height.px);
        // graphics.endFill();

        tmpSkin.width  = widget.width.px;
        tmpSkin.height = widget.height.px;

        if (widget.positionDependsOnSize()) widgetMoved();
    }


    /**
     * Called when widget position is changed.
     */
    public inline function widgetMoved () : Void
    {
        if (useOrigin) {
            updateTransform();
        } else {
            x = widget.left.px;
            y = widget.top.px;
        }
    }


    /**
     * Called when widget rotation is changed
     */
    public inline function widgetRotated () : Void
    {
        if (useOrigin) {
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
        if (useOrigin) {
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
        if (useOrigin) {
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
     * Called when skin of a widget was changed
     */
    public function widgetSkinChanged () : Void
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
        matrix.translate(-widget.origin.left.px, -widget.origin.top.px);
        if (widget.scaleX != 0 || widget.scaleY != 0) {
            matrix.scale(widget.scaleX, widget.scaleY);
        }
        if (widget.rotation != 0) {
            matrix.rotate(widget.rotation * Math.PI / 180);
        }
        matrix.translate(widget.left.px, widget.top.px);

        transform.matrix = matrix;
    }


    /**
     * Setter for `wparent`
     */
    private function set_wparent (wparent:Widget) : Widget
    {
        this.wparent = wparent;

        if (wparent != null) {
            if (widget.sizeDependsOnParent()) widgetResized();
            if (widget.positionDependsOnParent()) widgetMoved();
        }

        return wparent;
    }

}//class Backend