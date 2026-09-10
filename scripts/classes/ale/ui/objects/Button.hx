package ale.ui.objects;

import ale.ui.objects.MouseSpriteGroup;

import ale.ui.Utils;

class Button extends MouseSpriteGroup
{
    var bg:FlxSprite;
    
    public function new(?width:Float = 3, ?height:Int = 1, ?color:FlxColor)
    {
        super();

        width ??= 4;
        height ??= 1;

        bg = Utils.roundSprite(width, height, color);
        add(bg);
    }
}