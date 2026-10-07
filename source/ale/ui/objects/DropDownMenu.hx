package ale.ui.objects;

import ale.ui.objects.InputText;
import ale.ui.objects.Button;

import ale.ui.core.SpriteGroup;

import ale.ui.Config;
import ale.ui.Utils;

import flixel.math.FlxMath;
import flixel.math.FlxRect;

import flixel.util.FlxColor;

import flixel.FlxG;

class DropDownMenu extends SpriteGroup
{
    var inputText:InputText;

    var button:Button;

    var buttons:SpriteGroup;

    public var options(default, set):Array<String>;
    function set_options(val:Array<String>):Array<String>
    {
        val = Utils.deleteDuplicates(val);

        if (val.length <= 0)
            return options;

        options = val;

        inputText.hints = options;

        regenButtons();

        if (!options.contains(value))
            value = options[0];

        return options;
    }

    public var open(default, set):Bool;
    function set_open(val:Bool):Bool
    {
        open = val;

        updateButtonsPosition(0, uHeight);

        buttons.visible = buttons.active = open;

        button.label.text = open ? '-' : '+';

        return open;
    }

    public var disabled(default, set):Bool;
    function set_disabled(val:Bool):Bool
    {
        disabled = val;

        open = false;

        inputText.disabled = button.disabled = disabled;

        return disabled;
    }

    public var value(default, set):String;
    function set_value(val:String):String
    {
        value = val;

        inputText.value = value;

        updateTarget(value);

        return value;
    }

    final uWidth:Int;
    final uHeight:Int;
    final uColor:Int;

    public function new(?x:Float, ?y:Float, ?options:Array<String>, ?initial:String, ?hint:String = 'Enter option...', ?width:Int = 3, ?height:Int = 1, ?buttonWidth:Int = 1, ?color:FlxColor)
    {
        super(x, y);

        uWidth = width;
        uHeight = height;
        uColor = color;

        buttons = new SpriteGroup(0, height);
        add(buttons);

        inputText = new InputText(0, 0, hint, null, null, width, height, {
            color: color,
            topRight: 0,
            bottomRight: 0
        });
        inputText.onSubmit = val -> options.contains(val) ? value = val : value = value;
        add(inputText);

        button = new Button(width, 0, '+', null, buttonWidth, height, {
            color: color,
            topLeft: 0,
            bottomLeft: 0
        });
        button.callback = () -> open = !open;
        add(button);

        this.value = initial ?? options[0];

        this.options = options;

        open = false;
    }

    var cooldown:Float = 0;

    public function addOption(opt:String):Array<String>
    {
        options.push(opt);

        return options = options;
    }

    public function insertOption(index:Int, opt:String):Array<String>
    {
        options.insert(index, opt);

        return options = options;
    }

    public function removeOption(opt:String):Array<String>
    {
        options.remove(opt);

        options = options;

        return options = options;
    }

    public function replaceOption(index:Int, opt:String):Array<String>
    {
        if (options[index] != null)
            options[index] = opt;

        return options = options;
    }

    override function update(elapsed:Float)
    {
        if (!disabled && open && inputText.bg.overlaped)
        {
            if (FlxG.mouse.wheel != 0)
                updateButtonsPosition(FlxG.mouse.wheel);

            if (FlxG.mouse.pressed && FlxG.mouse.deltaY != 0)
                if (cooldown > 0)
                {
                    cooldown -= elapsed;
                } else {
                    cooldown = 0.05;

                    updateButtonsPosition(FlxMath.signOf(FlxG.mouse.deltaY));
                }
        }

        super.update(elapsed);
    }

    function updateButtonsPosition(factor:Int, ?pos:Int)
    {
        buttons.y = pos == null ? FlxMath.bound(buttons.y + factor * Config.SIZE, y - buttons.height + Config.SIZE * 2, y + Config.SIZE) : y + pos * Config.SIZE;

        buttons.clipRect = FlxRect.get(0, y + Config.SIZE - buttons.y, buttons.width, buttons.height);
    }

    function regenButtons()
    {
        buttons.clear();

        updateButtonsPosition(0, uHeight);

        var last = 0;

        for (i => opt in options)
        {
            final group = new SpriteGroup(0, last);

            final text = Utils.text(opt, inputText.width * Config.DROPDOWN_SIZE_X, inputText.height * Config.DROPDOWN_SIZE_Y);

            final height = Math.ceil(text.height / Config.SIZE);

            final bg = Utils.roundMouseSprite(uWidth, height, {
                color: uColor,
                topLeft: i <= 0 ? Config.MARGIN_SIZE : 0,
                topRight: i <= 0 ? Config.MARGIN_SIZE : 0,
                bottomLeft: i >= options.length - 1 ? Config.MARGIN_SIZE : 0,
                bottomRight: i >= options.length - 1 ? Config.MARGIN_SIZE : 0
            });
            bg.onOverlapChange = over -> group.brightness = over ? 0.1 : 0;
            bg.onPressChange = press -> if (!press)
            {
                bg.onOverlapChange(false);

                open = false;

                value = opt;
            }

            Utils.center(text, bg);

            group.add(bg);
            group.add(text);

            buttons.add(group);

            last += height;
        }
    }
}