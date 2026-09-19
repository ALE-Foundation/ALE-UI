package ale.ui.objects;

import ale.ui.Utils;

class Slider extends ale.ui.core.SpriteGroup
{
    public var min(default, set):Float;
    function set_min(val:Float):Float
    {
        if (min == val)
            return min;

        min = val;

        if (value != null)
            value = value;

        return min;
    }

    public var max(default, set):Float;
    function set_max(val:Float):Float
    {
        if (max == val)
            return max;

        max = val;

        if (value != null)
            value = value;

        return max;
    }

    public var value(default, set):Float;
    function set_value(val:Float):Float
    {
        val = FlxMath.bound(val, min, max);

        if (!decimal)
            val = Math.floor(val);

        if (value == val)
            return;

        value = val;

        text.text = FlxMath.roundDecimal(value, 2);
        text.x = bg.x + bg.width + button.width * 1.5 - text.width / 2;

        button.x = bg.x - button.width / 2 + bg.width * (max == min ? 0 : (value - min) / (max - min));

        updateTarget(value);

        return value;
    }

    public var decimal(default, set):Bool;
    function set_decimal(val:Bool):Bool
    {
        if (decimal == val)
            return decimal;

        if (value != null)
            value = value;

        return decimal = val;
    }

    var bg:Sprite;
    var button:MouseSprite;
    var label:FlxText;

    public function new(?x:Float, ?y:Float, ?min:Float = -1, ?max:Float = 1, ?def:Float = 0, ?decimal:Bool = true, ?width:Float = 4, ?height:Float = 0.5, ?buttonWidth:Float = 1, ?buttonHeight:Float = 1, ?style:RoundStyle)
    {
        min ??= -1;
        max ??= 1;

        width ??= 4;
        height ??= 0.5;
        buttonWidth ??= 1;
        buttonHeight ??= 1;

        decimal ??= true;

        def ??= 0;

        super(x, y);

        button = Utils.roundMouseSprite(buttonWidth, buttonHeight, style);
        button.onPressChange = pressed -> {
            button.brightness = pressed ? -0.25 : 0;

            if (pressed)
                _offset = FlxG.mouse.getViewPosition(camera).x - button.x;
        };

        bg = Utils.roundSprite(width, height, style);
        bg.alpha = 0.75;

        if (height < buttonHeight)
            bg.y = button.y + button.height / 2 - bg.height / 2;
        else
            button.y = bg.y + bg.height / 2 - button.height / 2;

        text = Utils.text('oso', null, button.height * Config.FONT_SIZE);
        text.y = bg.y + bg.height / 2 - text.height / 2;

        add(bg);
        add(button);
        add(text);

        this.max = max;
        this.min = min;

        this.decimal = decimal;

        value = def;
    }

    var _offset:Float = 0;

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (button.pressed && FlxG.mouse.deltaX != 0)
            value = min + ((FlxG.mouse.getViewPosition(camera).x - _offset + button.width / 2 - bg.x) / bg.width) * (max - min);
    }
}