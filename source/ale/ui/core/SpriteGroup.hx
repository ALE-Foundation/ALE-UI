package ale.ui.core;

import flixel.util.typeLimit.OneOfTwo;

import flixel.FlxG;

import ale.ui.Config;

class SpriteGroup extends flixel.group.FlxSpriteGroup implements ale.ui.interfaces.IObject
{
    var _uiTarget:Dynamic;
    var _targetProperties:Array<String>;
    var _targetUpdate:Dynamic -> Void;


    public function updateTarget(value:Dynamic):Dynamic
    {
        if (_uiTarget != null && _targetProperties != null && _targetUpdate != null)
            _targetUpdate(value);

        return value;
    }

    public function setTarget(obj:Dynamic, props:OneOfTwo<String, Array<String>>, ?func:Dynamic -> Void)
    {
        _uiTarget = obj;
        _targetProperties = cast props is Array ? props : [props];
        _targetUpdate = func ?? val -> for (prop in _targetProperties) Reflect.setProperty(_uiTarget, prop, val);
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