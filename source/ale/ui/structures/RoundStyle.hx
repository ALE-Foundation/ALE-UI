package ale.ui.structures;

import flixel.util.FlxColor;

typedef RoundStyle = {
    ?color:FlxColor,

    ?topLeft:Float,
    ?topRight:Float,
    ?bottomLeft:Float,
    ?bottomRight:Float,

    ?gradient:Array<FlxColor>
}