package ale.ui.core;

import flixel.FlxG;

import ale.ui.Config;
import ale.ui.Utils;

class SpriteGroup extends flixel.group.FlxSpriteGroup implements ale.ui.interfaces.IObject
{
    public function new(?x:Float, ?y:Float)
    {
        super();

        place(x, y);
    }
    
    public var brightness(never, set):Float;
    function set_brightness(value:Float):Float
	{
		for (spr in members)
			spr.colorTransform.redOffset = spr.colorTransform.greenOffset = spr.colorTransform.blueOffset = value * 255;
		
		return value;
	}

    public function place(?uX:Float, ?uY:Float, ?right:Bool = false, ?down:Bool = false):Void
        Utils.place(this, uX, uY, right, down);
}