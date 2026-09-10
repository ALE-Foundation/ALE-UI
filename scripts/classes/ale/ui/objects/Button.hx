package ale.ui.objects;

import ale.ui.objects.MouseSpriteGroup;

import ale.ui.Utils;

class Button extends MouseSpriteGroup
{
    var bg:FlxSprite;
    
    public function new(?x:Float, ?y:Float, ?width:Float = 3, ?height:Int = 1, ?color:FlxColor)
    {
        super(x, y);

        width ??= 4;
        height ??= 1;

        bg = Utils.roundSprite(width, height, color);
        add(bg);
    }
}