package sx.backend.flash;

import flash.display.Sprite;
import sx.widgets.Widget;



/**
 * StablexUI backend implementation on top of flash display list.
 *
 */
class Backend extends Sprite
{
    /** Owner of this backend instance */
    private var widget : Widget;
    /** Parent widget */
    private var wparent : Widget;


    /**
     * Constructor
     */
    public function new (widget:Widget) : Void
    {
        this.widget = widget;
    }


    /**
     * Get parent widget
     */
    public inline function getParent () : Null<Widget>
    {
        return wparent;
    }


    /**
     * Get amount of child widgets in display list of current widget
     */
    public inline function getNumChildren () : Int
    {
        return numChildren;
    }


    /**
     * Add `child` to display list of this widget.
     *
     * Returns added child.
     */
    public inline function addWidget (child:Widget) : Widget
    {
        addChild(child.backend);
        child.backend.wparent = widget;
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
        index = clampIndex(index);
        addChild(child.backend, index);
        child.backend.wparent = widget;
    }


    /**
     * Remove `child` from display list of this widget.
     *
     * Returns removed child.
     * Returns `null` if this widget is not a parent for this `child`.
     */
    public inline function removeWidget (child:Widget) : Null<Widget>
    {
        if (child.backend.parent == this) {
            removeChild(child.backend);
            child.wparent = null;

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
        if (index < 0) index += numChildren;

        if (index >= 0 && index < numChildren) {
            var removed : Backend = cast removeChildAt(index);
            removed.wparent = null;

            return removed;
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
        beginIndex = clampIndex(beginindex);
        endIndex   = clampIndex(endIndex);

        if (0 <= beginIndex && beginIndex <= endIndex) {
            var removed : Backend;
            for (i in beginIndex...(endIndex + 1)) {
                removed = cast removeChildAt(i);
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
        if (child.wparent != widget) {
            throw new sx.exceptions.NotChildException();
        }

        return getChildIndex(child.backend);
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
        if (child.wparent != widget) {
            throw new sx.exceptions.NotChildException();
        }

        index = clampIndex(index);
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

    }


    /**
     * Swap two specified child widgets in display list.
     *
     * @throws sx.exceptions.NotChildException() If eighter `child1` or `child2` are not a child of this widget.
     */
    public inline function swapWidgets (child1:Widget, child2:Widget) : Void
    {

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

    }


    /**
     * Called when origin of a widget was changed
     */
    public inline function originChanged () : Void
    {

    }


    /**
     * Called when widget width/height is changed.
     */
    public inline function resized () : Void
    {

    }


    /**
     * Called when widget position is changed.
     */
    public inline function moved () : Void
    {

    }


    /**
     * Called when widget rotation is changed
     */
    public inline function rotated () : Void
    {

    }


    /**
     * Called when widget.scaleX is changed
     */
    public inline function scaledX () : Void
    {

    }


    /**
     * Called when widget.scaleY is changed
     */
    public inline function scaledY () : Void
    {

    }


    /**
     * Called when widget.alpha is changed
     */
    public inline function alphaChanged () : Void
    {

    }


    /**
     * Called when widget.visible is changed
     */
    public inline function visibilityChanged () : Void
    {

    }


    /**
     * Method to cleanup and release this object for garbage collector.
     */
    public inline function dispose () : Void
    {

    }


    /**
     * Description
     */
    private inline function clampIndex (index:Int) : Int
    {
        if (index < 0) {
            index += numChildren;
            if (index < 0) index = 0;
        } else if (index > numChildren) {
            index = numChildren;
        }

        return index;
    }

}//class Backend