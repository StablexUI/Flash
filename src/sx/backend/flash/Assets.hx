package sx.backend.flash;

import sx.backend.BitmapData;
import sx.backend.interfaces.IAssets;

#if macro
import  haxe.macro.Context;
import haxe.macro.Expr;
#end


/**
 * Assets manager
 *
 */
class Assets implements IAssets
{
    /** Cached bitmaps */
    private var __cache : Map<String, BitmapData>;


    /**
     * Constructor
     */
    public function new () : Void
    {
        __cache = new Map();
    }


    /**
     * Get bitmap identified by `id`
     */
    public function getBitmapData (id:String) : BitmapData
    {
        var bitmapData : BitmapData = null;

        #if (nme || openfl)
            bitmapData = openfl.Assets.getBitmapData(id);
        #end
        if (bitmapData == null) {
            bitmapData = __cache.get(id);
        }

        return bitmapData;
    }


    /**
     * Embed all assets in `dir` directory and make them available under `embedRoot` path.
     *
     * `dir` should be an absolute path or relative to the file where this method is called from.
     *
     * E.g. if called `assets.embed('../../assets/images', 'data/img') then you can access your assets like this:
     * ```
     * var bitmapData = assets.getBitmapData('data/img/pic.png');
     * ```
     * Where `pic.png` is a file located in `../../assets/images/pic.png` in your filesystem relative to the file where
     * that code is located.
     */
    macro public function embed (eThis:Expr, dir:String, embedRoot:String) : Expr
    {
        if (Context.defined('display')) return macro {};

        return {};
    }


}//class Assets