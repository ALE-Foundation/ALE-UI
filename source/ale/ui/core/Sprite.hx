package ale.ui.core;

import flixel.graphics.FlxGraphic;

import ale.ui.Config;
import ale.ui.Utils;

import flixel.FlxG;

class Sprite extends flixel.FlxSprite implements ale.ui.interfaces.IObject
{
    public function new(?x:Float, ?y:Float, ?graphic:FlxGraphic)
    {
        super(null, null, graphic);

        place(x, y);
    }

	public var brightness(never, set):Float;
    function set_brightness(value:Float):Float
	{
		colorTransform.redOffset = colorTransform.greenOffset = colorTransform.blueOffset = value * 255;
		
		return value;
	}

    public function place(?uX:Float, ?uY:Float, ?right:Bool = false, ?down:Bool = false):Void
        Utils.place(this, uX, uY, right, down);
}