package ale.ui.objects;

import ale.ui.objects.InputText;
import ale.ui.objects.Button;

import ale.ui.Utils;

class NumericStepper extends ale.ui.core.SpriteGroup
{
    var _decimals:Int;

    var inputText:InputText;
    var plusButton:Button;
    var minusButton:Button;

    public var change(default, set):Float;
    function set_change(val:Float):Float
    {
        if (change == val)
            return change;

        change = val;

        _decimals = FlxMath.getDecimals(change);

        return val;
    }

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
        if (Math.isNaN(val))
            val = min;

        val = FlxMath.bound(val, min, max);

        val = FlxMath.roundDecimal(val, _decimals);

        inputText.value = Std.string(val);

        if (value == val)
            return value;

        value = val;

        minusButton.disabled = value <= min;
        plusButton.disabled = value >= max;

        updateTarget(value);

        return value;
    }

    public function new(?x:Float, ?y:Float, ?min:Float = 0, ?max:Float = 100, ?def:Float = 0, ?change:Float = 1, ?hint:String = 'Enter number...', ?width:Int = 2, ?height:Int = 1, ?buttonWidth:Int = 1, ?color:FlxColor)
    {
        super(x, y);

        hint ??= 'Enter number...';

        min ??= 0;
        max ??= 100;
        def ??= 0;
        change ??= 1;

        width ??= 3;
        height ??= 1;
        buttonWidth ??= 1;

        inputText = new InputText(null, null, hint, null, null, width, height, {
            color: color,
            topRight: 0,
            bottomRight: 0
        });
        inputText.onSubmit = val -> value = Std.parseFloat(val);
        inputText.regex = ~/[^0-9.-]/g;

        minusButton = new Button(width, null, '-', () -> value -= change, buttonWidth, height, {
            color: color,
            topLeft: 0,
            topRight: 0,
            bottomLeft: 0,
            bottomRight: 0
        });

        plusButton = new Button(width + buttonWidth, null, '+', () -> value += change, buttonWidth, height, {
            color: color,
            topLeft: 0,
            bottomLeft: 0
        });

        add(inputText);
        add(minusButton);
        add(plusButton);

        this.min = min;
        this.max = max;

        this.change = change;

        value = def;
    }
}