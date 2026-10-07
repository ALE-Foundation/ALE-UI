package ale.ui.core;

import ale.ui.Config;

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

	public var allowUpdate:Bool = true;

    override function update(elapsed:Float)
    {
        if (!allowUpdate)
            return;

        uiUpdate(elapsed);

        super.update(elapsed);
    }

    public function uiUpdate(elapsed:Float) {}

    public var allowDraw:Bool = true;

    override function draw()
    {
        if (!allowDraw)
            return;

        uiDraw();

        super.draw();
    }

    public function uiDraw() {}

    public function place(?uX:Float, ?uY:Float, ?right:Bool = false, ?down:Bool = false):Void
    {
        if (uX != null)
        {
            x = uX * Config.SIZE;

            if (right)
                x = FlxG.width - width - x;
        }

        if (uY != null)
        {
            y = uY * Config.SIZE;

            if (down)
                y = FlxG.height - height - y;
        }
    }
}