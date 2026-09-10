package ale.ui;

import ale.ui.Defaults;

class Config
{
    public static var COLOR:FlxColor = Defaults.COLOR;

    public static var OUTLINE_COLOR:FlxColor = Defaults.OUTLINE_COLOR;

    public static var SIZE:Float = Defaults.SIZE;

    public static function reset()
    {
        COLOR = Defaults.COLOR;

        OUTLINE_COLOR = Defaults.OUTLINE_COLOR;

        SIZE = Defaults.SIZE;
    }
}