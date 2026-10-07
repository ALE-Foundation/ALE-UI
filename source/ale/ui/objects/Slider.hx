package ale.ui.objects;

import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.FlxG;

import ale.ui.structures.RoundStyle;
import ale.ui.core.MouseSprite;
import ale.ui.core.Sprite;
import ale.ui.core.Text;
import ale.ui.Utils;

class Slider extends ale.ui.core.ValueGroup<Float>
{
    public var min(default, set):Float;
    function set_min(val:Float):Float
    {
        min = val;

        if ((value : Null<Float>) != null)
            value = value;

        return min;
    }

    public var max(default, set):Float;
    function set_max(val:Float):Float
    {
        max = val;

        if ((value : Null<Float>) != null)
            value = value;

        return max;
    }

    override function set_value(val:Float):Float
    {
        val = FlxMath.bound(val, min, max);

        if (!decimal)
            val = Math.floor(val);

        value = val;

        label.text = Std.string(FlxMath.roundDecimal(value, 2));

        button.x = bg.x - button.width / 2 + bg.width * (max == min ? 0 : (value - min) / (max - min));

        label.x = button.x + button.width / 2 - label.width / 2;

        return super.set_value(value);
    }

    public var decimal(default, set):Bool;
    function set_decimal(val:Bool):Bool
    {
        if ((value : Null<Float>) != null)
            value = value;

        return decimal = val;
    }

    var bg:Sprite;
    var button:MouseSprite;
    var label:Text;

    public function new(?x:Float, ?y:Float, ?min:Float = -1, ?max:Float = 1, ?def:Float = 0, ?decimal:Bool = true, ?width:Float = 4, ?height:Float = 0.5, ?buttonWidth:Float = 1, ?buttonHeight:Float = 1, ?style:RoundStyle)
    {
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

        label = Utils.text('', null, button.height * Config.FONT_SIZE);
        label.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1);
        label.y = bg.y + bg.height / 2 - label.height / 2;

        add(bg);
        add(button);
        add(label);

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