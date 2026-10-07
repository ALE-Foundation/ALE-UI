package ale.ui.core;

import ale.ui.Config;
import ale.ui.Utils;

import flixel.FlxG;

class Text extends flixel.text.FlxText
{
    public function new(?x:Float, ?y:Float, ?width:Float, ?text:String, ?size:Int, ?embeddedFont:Bool)
    {
        super(0, 0, width, text, size, embeddedFont);

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