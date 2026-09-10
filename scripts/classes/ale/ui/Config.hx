package ale.ui;

import ale.ui.Defaults;

class Config
{
    public static var COLOR:FlxColor = Defaults.COLOR;
    public static var OUTLINE_COLOR:FlxColor = Defaults.OUTLINE_COLOR;

    public static var SIZE:Float = Defaults.SIZE;

    public static var FONT:String = Defaults.FONT;
    public static var FONT_SCALE:Float = Defaults.FONT_SCALE;
    public static var FONT_COLOR:FlxColor = Defaults.FONT_COLOR;

    public static function reset()
    {
        COLOR = Defaults.COLOR;
        OUTLINE_COLOR = Defaults.OUTLINE_COLOR;

        SIZE = Defaults.SIZE;

        FONT = Defaults.FONT;
        FONT_SCALE = Defaults.FONT_SCALE;
        FONT_COLOR = Defaults.FONT_COLOR;
    }
}