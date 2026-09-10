package ale.ui;

import flixel.graphics.FlxGraphic;

import flixel.FlxObject;

import openfl.display.GradientType;
import openfl.display.BitmapData;
import openfl.display.Shape;

import openfl.geom.Matrix;

import ale.ui.objects.Sprite;

import ale.ui.Config;

class Utils
{
    public static function roundSprite(width:Float, height:Float, ?color:FlxColor, ?manualGradient:Array<FlxColor>, ?topLeft:Bool, ?topRight:Bool, ?bottomLeft:Bool, ?bottomRight:Bool):Sprite
        return new Sprite(0, 0, roundGraphic(width, height, color, manualGradient));

    public static function roundGraphic(width:Float, height:Float, ?color:FlxColor, ?manualGradient:Array<FlxColor>, ?topLeft:Bool = true, ?topRight:Bool = true, ?bottomLeft:Bool = true, ?bottomRight:Bool = true):FlxGraphic
    {
        color ??= Config.COLOR;

        final size = intAdjust(width, height);

        final bitmap:BitmapData = new BitmapData(size.x, size.y, true, 0x0);

        final matrix:Matrix = new Matrix();
        matrix.createGradientBox(size.x, size.y, Math.PI / 2);
        
        function roundSize(cond:Bool):Float
            return cond ? Config.SIZE / 4 : 0;

        final shape:Shape = new Shape();
        shape.graphics.beginGradientFill(GradientType.LINEAR, manualGradient ?? [dark(0.5, color), dark(0.7, color)], [1, 1], [0, 255], matrix);
        shape.graphics.lineStyle(Config.OUTLINE_SIZE, Config.OUTLINE_COLOR);
        shape.graphics.drawRoundRectComplex(Config.OUTLINE_SIZE / 2, Config.OUTLINE_SIZE / 2, size.x - Config.OUTLINE_SIZE, size.y - Config.OUTLINE_SIZE, roundSize(topLeft), roundSize(topRight), roundSize(bottomLeft), roundSize(bottomRight));
        shape.graphics.endFill();
        
        bitmap.draw(shape);

        return FlxGraphic.fromBitmapData(bitmap);
    }


    public static function label(?lab:String = 'Label', follow:FlxObject):FlxText
    {
        lab ??= 'Label';

        final text:FlxText = new FlxText(0, 0, follow.width, lab, Math.min(follow.width, follow.height) * Config.FONT_SIZE);
        text.color = Config.FONT_COLOR;
        text.font = Config.FONT;
        text.alignment = 'center';

        return text;
    }

    public static function center(a:FlxSprite, b:FlxSprite)
    {
        a.x = b.x + b.width / 2 - a.width / 2;
        a.y = b.y + b.height / 2 - a.height / 2;
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
        return {
            x: Math.max(1, width) * Config.SIZE,
            y: Math.max(1, height) * Config.SIZE
        };


    public static function light(percent:Float, ?a:FlxColor):FlxColor
        return mix(FlxColor.WHITE, percent, a);

    public static function dark(percent:Float, ?a:FlxColor):FlxColor
        return mix(FlxColor.BLACK, percent, a);

    public static function mix(b:FlxColor, percent:Float, ?a:FlxColor):FlxColor
    {
        a ??= Config.COLOR;

        return FlxColor.interpolate(a, b, percent);
    }
}