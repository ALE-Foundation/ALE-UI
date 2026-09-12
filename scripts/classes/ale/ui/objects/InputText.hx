package ale.ui.objects;

import ale.ui.objects.SpriteGroup;
import ale.ui.objects.Sprite;
import ale.ui.Config;
import ale.ui.Utils;

import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;

import openfl.events.KeyboardEvent;
import openfl.ui.Mouse;

class InputText extends SpriteGroup
{
    var bg:Sprite;

    var backText:FlxText;
    var text:FlxText;

    var cursor:Sprite;

    public var writing(default, set):Bool;
    function set_writing(val:Bool):Bool
    {
        if (writing == val)
            return writing;

        FlxG.stage.window.textInputEnabled = val;

        cursor.visible = cursor.alive = val;

        timer = 0.5;

        return writing = val;
    }

    public var position(default, set):Int;
    function set_position(val:Int):Int
    {
        if (position == val)
            return position;

        val = FlxMath.bound(val, 0, value.length);

        cursor.x = (text.x + (value.length <= 0 ? 0 : val >= value.length ? text.width : text.textField.getCharBoundaries(val).x)) - cursor.width / 2;

        cursor.visible = cursor.alive;
        timer = 0.5;

        return position = val;
    }

    public var value(default, set):String;
    function set_value(val:String):String
    {
        if (value == val)
            return value;

        val ??= '';

        backText.visible = val.length <= 0;

        text.text = val;

        return value = val;
    }

    public function new(?x:Float, ?y:Float, ?back:String = 'Enter text...', ?def:String = '', ?width:Float = 4, ?height:Float = 1, ?color:FlxColor)
    {
        super(x, y);

        bg = Utils.roundMouseSprite(width, height, color ?? Utils.gray(0.5));
        bg.onOverlapChange = over -> Mouse.cursor = over ? 'ibeam' : 'arrow';

        backText = Utils.text(back, 0, bg.height * Config.INPUT_SIZE);
        backText.alpha = 0.5;

        text = Utils.text('oso', 0, bg.height * Config.INPUT_SIZE);

        cursor = new Sprite();
        cursor.makeGraphic(Config.CURSOR_SIZE, bg.height - Config.SIZE * Config.MARGIN);

        for (obj in [backText, text, cursor])
            obj.setPosition(Config.SIZE * Config.MARGIN, bg.height / 2 - obj.height / 2);

        add(bg);
        add(backText);
        add(text);
        add(cursor);

        FlxG.stage.addEventListener('keyDown', onKeyDown, false, 1);

		FlxG.stage.window.onTextInput.add(onTextInput);

        value = def;
        position = value.length;

        writing = false;
    }

    var timer:Float = 0.5;
    
    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.mouse.justPressed)
        {
            writing = bg.overlaped;

            if (writing)
            {
                if (value.length > 0)
                {
                    #if mobile
                    position = value.length;
                    #else
                    final diff:Float = FlxG.mouse.getViewPosition(camera).x - text.x;
                    
                    final pos:Int = text.textField.getCharIndexAtPoint(diff, text.y + 1);

                    position = pos <= -1 && diff > 0 ? value.length : pos;
                    #end
                } else {
                    position = 0;
                }
            }
        }

        if (cursor.alive)
            if (timer > 0)
            {
                timer -= elapsed;
            } else {
                cursor.visible = !cursor.visible;

                timer = 0.5;
            }
    }

    function onKeyDown(e:KeyboardEvent)
    {
        if (!writing)
            return;

        if (e.ctrlKey)
        {
            switch (e.keyCode)
            {
                
            }
        } else {
            switch (e.keyCode)
            {
                case FlxKey.BACKSPACE:
                    if (value.length > 0)
                    {
                        value = value.substring(0, position - 1) + value.substring(position);

                        position--;
                    }

                case FlxKey.DELETE:
                    if (value.length > 0)
                        value = value.substring(0, position) + value.substring(position + 1);

                case FlxKey.TAB:
                    insertText(Config.TAB);

                case FlxKey.LEFT:
                    position--;

                case FlxKey.RIGHT:
                    position++;
            }
        }
    }

	function onTextInput(toAdd:String)
        insertText(toAdd);

    function insertText(toAdd:String)
    {
        value = value.substring(0, position) + toAdd + value.substring(position);

        position += toAdd.length;
    }

    override function destroy()
    {
        super.destroy();
        
        FlxG.stage.removeEventListener('keyDown', onKeyDown, false);
		
		FlxG.stage.window.onTextInput.remove(onTextInput);

        writing = false;
    }
}