package ale.ui;

class Defaults
{
    public static final COLOR:FlxColor = FlxColor.fromRGB(80, 50, 255);

    public static final OUTLINE_SIZE:Float = 1.5;
    public static final OUTLINE_COLOR:FlxColor = light(COLOR, 0.75);

    public static final SIZE:Float = 25;

    public static final FONT:String = Paths.font('montserrat.ttf');
    public static final FONT_SIZE:Float = 0.7;
    public static final FONT_COLOR:FlxColor = FlxColor.WHITE;

    // ts should be on Utils

    static function light(col1, perc):FlxColor
        return mix(col1, FlxColor.WHITE, perc);

    static function gray(col1, perc):FlxColor
        return mix(col1, FlxColor.GRAY, perc);

    static function mix(col1, col2, perc):FlxColor
        return FlxColor.interpolate(col1, col2, perc);
}