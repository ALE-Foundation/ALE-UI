package ale.ui.objects;

import ale.ui.objects.SpriteGroup;
import ale.ui.objects.Sprite;
import ale.ui.Config;
import ale.ui.Utils;

import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;

import openfl.events.KeyboardEvent;
import openfl.ui.Mouse;

import lime.system.Clipboard;

using StringTools;

class InputText extends SpriteGroup
{
    var bg:Sprite;

    var backText:FlxText;
    var text:FlxText;

    var cursor:Sprite;

    public var disabled(default, set):Bool;
    function set_disabled(val:Bool):Bool
    {
        if (disabled == val)
            return disabled;

        typing = false;

        brightness = val ? -0.5 : 0;

        return disabled = val;
    }

    public var typing(default, set):Bool;
    function set_typing(val:Bool):Bool
    {
        if (typing == val)
            return typing;

        FlxG.stage.window.textInputEnabled = val;

        cursor.visible = cursor.alive = val;

        timer = 0.5;

        return typing = val;
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
        cursor.alpha = 0.75;

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

        typing = false;
    }

    var timer:Float = 0.5;
    
    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (disabled)
            return;

        if (FlxG.mouse.justPressed)
        {
            typing = bg.overlaped;

            if (typing)
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

    /*
    var isWord:Int -> Bool = code -> (code >= '0'.code && code <= '9'.code) || (code >= 'A'.code && code <= 'Z'.code) || (code >= 'a'.code && code <= 'z'.code);
    var isSpace:Int -> Bool = code -> code == ' '.code || code == '\t'.code || code == '\n'.code || code == '\r'.code;
    var isSymbol:Int -> Bool = code -> !isWord(code) && !isSpace(code);
    */

    // i blame rulescript
    var isWord:Int -> Bool = code -> (code >= 48 && code <= 57) || (code >= 65 && code <= 90) || (code >= 97 && code <= 122);
    var isSpace:Int -> Bool = code -> code == 32 || code == 9 || code == 10 || code == 13;
    var isSymbol:Int -> Bool = code -> !isWord(code) && !isSpace(code);

    var regexes:Void -> Array<Int -> Bool> = () -> [isWord, isSpace, isSymbol];

    function onKeyDown(e:KeyboardEvent)
    {
        if (!typing)
            return;

        switch (e.keyCode)
        {
            case FlxKey.ENTER, FlxKey.ESCAPE:
                typing = false;

            case FlxKey.HOME:
                position = 0;

            case FlxKey.END:
                position = value.length;


            case FlxKey.BACKSPACE:
                if (value.length > 0 && position > 0)
                {
                    if (e.ctrlKey && position > 1)
                    {
                        final end:Int = scan(true);

                        value = value.substring(0, end) + value.substring(position);

                        position = end;
                    } else {
                        value = value.substring(0, position - 1) + value.substring(position);

                        position--;
                    }
                }

            case FlxKey.DELETE:
                if (value.length > 0 && position < value.length)
                    value = value.substring(0, position) + value.substring(e.ctrlKey && position < value.length ? scan(false) : (position + 1));

            case FlxKey.TAB:
                insertText(Config.TAB);

            case FlxKey.LEFT:
                if (e.ctrlKey)
                    position = scan(true);
                else
                    position--;

            case FlxKey.RIGHT:
                if (e.ctrlKey)
                    position = scan(false);
                else
                    position++;

            case FlxKey.C:
                if (e.ctrlKey)
                    Clipboard.text = value;

            case FlxKey.V:
                if (e.ctrlKey)
                    insertText(Clipboard.text.replace(~/(?:\s)/g, ' '));

            default:
        }
    }

    function getRegex(code:Int)
    {
        for (reg in regexes())
            if (reg(code))
                return reg;

        return null;
    }

    function scan(left:Bool):Int
    {
        var end = position;
        var index = left ? position - 1 : position;

        if (index < 0 || index >= value.length)
            return position;

        var code = value.fastCodeAt(index);

        var reg = getRegex(code);

        end += left ? -1 : 1;

        if (isSpace(code))
        {
            index += left ? -1 : 1;

            if (index < 0 || index >= value.length)
                return end;

            code = value.fastCodeAt(index);

            if (!isSpace(code))
            {
                reg = getRegex(code);

                end += left ? -1 : 1;
            }
        }

        if (reg == null)
            return end;

        while (true)
        {
            index = left ? end - 1 : end;

            if (index < 0 || index >= value.length || !reg(value.fastCodeAt(index)))
                break;

            end += left ? -1 : 1;
        }

        return end;
    }

	function onTextInput(toAdd:String)
        insertText(toAdd);

    function insertText(toAdd:String)
    {
        if (!typing)
            return;

        value = value.substring(0, position) + toAdd + value.substring(position);

        position += toAdd.length;
    }

    override function destroy()
    {
        super.destroy();
        
        FlxG.stage.removeEventListener('keyDown', onKeyDown, false);
		
		FlxG.stage.window.onTextInput.remove(onTextInput);

        typing = false;
    }
}