package ale.ui;

import flixel.graphics.FlxGraphic;

import openfl.display.GradientType;
import openfl.display.BitmapData;
import openfl.display.Shape;

import openfl.geom.Matrix;

import ale.ui.Config;

class Utils
{
    public static function roundSprite(width:Float, height:Float, ?color:FlxColor):FlxSprite
    {
        return new FlxSprite(0, 0, roundGraphic(width, height, color));
    }

    public static function roundGraphic(width:Float, height:Float, ?color:FlxColor):FlxGraphic
    {
        color ??= Config.COLOR;

        final size = intAdjust(width, height);

        final bitmap = new BitmapData(size.x, size.y, true, 0x0);

        final matrix = new Matrix();
        matrix.createGradientBox(size.x, size.y, Math.PI / 2);
        
        final shape = new Shape();
        shape.graphics.beginGradientFill(GradientType.LINEAR, [dark(0.5, color), dark(0.7, color)], [1, 1], [0, 255], matrix);
        shape.graphics.lineStyle(2, Config.OUTLINE_COLOR);
        shape.graphics.drawRoundRect(1, 1, size.x - 2, size.y - 2, Config.SIZE / 2);
        shape.graphics.endFill();
        
        bitmap.draw(shape);

        return FlxGraphic.fromBitmapData(bitmap);
    }


    public static function intAdjust(width:Float, height:Float):{x:Int, y:Int}
    {
        final data = adjust(width, height);

        return {
            x: Std.int(data.x),
            y: Std.int(data.y)
        };
    }

    public static function adjust(width:Float, height:Float):{x:Float, y:Float}
    {
        return {
            x: Math.max(1, width) * Config.SIZE,
            y: Math.max(1, height) * Config.SIZE
        };
    }


    public static function light(percent:Float, ?a:FlxColor):FlxColor
    {
        return mix(FlxColor.WHITE, percent, a);
    }

    public static function dark(percent:Float, ?a:FlxColor):FlxColor
    {
        return mix(FlxColor.BLACK, percent, a);
    }

    public static function mix(b:FlxColor, percent:Float, ?a:FlxColor):FlxColor
    {
        a ??= Config.COLOR;

        return FlxColor.interpolate(a, b, percent);
    }
}