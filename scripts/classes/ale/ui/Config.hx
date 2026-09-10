package ale.ui;

import ale.ui.Defaults;

class Config
{
    public static var COLOR:FlxColor = Defaults.COLOR;

    public static var SIZE:Float = Defaults.SIZE;

    public static var OUTLINE_SIZE:Float = Defaults.OUTLINE_SIZE;
    public static var OUTLINE_COLOR:FlxColor = Defaults.OUTLINE_COLOR;

    public static var FONT:String = Defaults.FONT;
    public static var FONT_SIZE:Float = Defaults.FONT_SIZE;
    public static var FONT_COLOR:FlxColor = Defaults.FONT_COLOR;

    public static function reset()
    {
        COLOR = Defaults.COLOR;

        SIZE = Defaults.SIZE;

        OUTLINE_SIZE = Defaults.OUTLINE_SIZE;
        OUTLINE_COLOR = Defaults.OUTLINE_COLOR;

        FONT = Defaults.FONT;
        FONT_SIZE = Defaults.FONT_SIZE;
        FONT_COLOR = Defaults.FONT_COLOR;
    }
}