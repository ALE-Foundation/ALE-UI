package ale.ui.objects;

class Sprite extends scripting.haxe.ScriptedFlxSprite implements ale.ui.interfaces.IObject
{
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
}