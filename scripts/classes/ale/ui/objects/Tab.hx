package ale.ui.objects;

import ale.ui.objects.SpriteGroup;
import ale.ui.Config;
import ale.ui.Utils;

import flixel.math.FlxPoint;

class Tab extends SpriteGroup
{
    var border:MouseSprite;
    var title:FlxText;

    var bg:Sprite;

    public var movable(default, set):Bool;
    function set_movable(value:Bool):Bool
    {
        if (movable == value)
            return movable;

        if (!value)
        {
            snap();

            _moving = false;
        }

        return movable = value;
    }

    var _moving:Bool = false;

    var _mouseOffset:FlxPoint = FlxPoint.get();

    public function new(?x:Float, ?y:Float = 1, ?text:String = 'Tab', ?width:Float = 8, ?height:Float = 6, ?borderHeight:Float = 1, ?color:FlxColor)
    {
        super(x, y);

        border = Utils.roundMouseSprite(width, borderHeight, null, true, true, false, false, [Utils.dark(0.25, color), Utils.dark(0.5, color)]);
        border.place(null, -borderHeight);
        border.onPressChange = pressed -> {
            if (!movable)
                return;

            _moving = pressed;

            if (_moving)
            {
                final pos = FlxG.mouse.getViewPosition(camera);

                _mouseOffset.x = pos.x - this.x;
                _mouseOffset.y = pos.y - this.y;
            } else {
                snap();
            }
        };

        title = Utils.label(text, border);

        bg = Utils.roundSprite(width, height, null, false, false, true, true, [Utils.dark(0.75, color), Utils.dark(0.9, color)]);

        add(border);
        add(title);
        add(bg);

        movable = true;
    }

    override function update(elapsed:Float)
    {
        if (_moving)
        {
            final pos = FlxG.mouse.getViewPosition(camera);

            x = pos.x - _mouseOffset.x;
            y = pos.y - _mouseOffset.y;
        }

        super.update(elapsed);
    }

    function snap()
    {
        if (x <= -border.width)
            x = -border.width + Config.SIZE;

        if (x >= FlxG.width)
            x = FlxG.width - Config.SIZE;

        if (y <= 0)
            y = Config.SIZE;

        if (y >= FlxG.height + Config.SIZE)
            y = FlxG.height;
    }
}