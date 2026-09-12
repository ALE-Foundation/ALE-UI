package ale.ui;

import ale.ui.Defaults;

class Config
{
    public static var COLOR:FlxColor = Defaults.COLOR;

    public static var SIZE:Float = Defaults.SIZE;
    public static var MARGIN:Float = Defaults.MARGIN;

    public static var OUTLINE_SIZE:Float = Defaults.OUTLINE_SIZE;
    public static var OUTLINE_LIGHT:Float = 0.5;

    public static var FONT:String = Defaults.FONT;
    public static var FONT_SIZE:Float = Defaults.FONT_SIZE;
    public static var FONT_COLOR:FlxColor = Defaults.FONT_COLOR;

    public static var CURSOR_SIZE:Float = Defaults.CURSOR_SIZE;

    public static var TAB:String = Defaults.TAB;
    
    public static var INPUT_SIZE:Float = Defaults.INPUT_SIZE;

    public static function reset()
    {
        COLOR = Defaults.COLOR;

        SIZE = Defaults.SIZE;
        MARGIN = Defaults.MARGIN;

        OUTLINE_SIZE = Defaults.OUTLINE_SIZE;
        OUTLINE_LIGHT = Defaults.OUTLINE_LIGHT;

        FONT = Defaults.FONT;
        FONT_SIZE = Defaults.FONT_SIZE;
        FONT_COLOR = Defaults.FONT_COLOR;

        CURSOR_SIZE = Defaults.CURSOR_SIZE;

        TAB = Defaults.TAB;

        INPUT_SIZE = Defaults.INPUT_SIZE;
    }
}