package ale.ui.objects;

import ale.ui.Config;

class SpriteGroup extends scripting.haxe.ScriptedFlxSpriteGroup implements ale.ui.interfaces.IObject
{
    var _target:Dynamic;
    var _targetProperty:Dynamic;
    var _targetUpdate:Dynamic -> Void;


    public function updateTarget(value:Dynamic):Dynamic
        if (_target != null && _targetProperty != null && _targetUpdate != null)
            _targetUpdate(value);

    public function setTarget(obj:Dynamic, prop:String, ?func:Dynamic -> Void)
    {
        _target = obj;
        _targetProperty = prop;
        _targetUpdate = func ?? val -> Reflect.setProperty(_target, _targetProperty, val);
    }


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