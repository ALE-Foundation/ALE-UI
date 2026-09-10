package ale.ui.objects;

import ale.ui.objects.MouseSpriteGroup;

import ale.ui.Utils;

class Button extends MouseSpriteGroup
{
    var bg:FlxSprite;
    var label:FlxText;
    
    public function new(?x:Float, ?y:Float, ?text:String, ?width:Float = 3, ?height:Int = 1, ?color:FlxColor)
    {
        super(x, y);

        width ??= 4;
        height ??= 1;

        bg = Utils.roundSprite(width, height, color);
        add(bg);

        label = Utils.label(text, bg);
        add(label);
    }
}