package ale.ui;

import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;
import flixel.FlxObject;

import openfl.display.GradientType;
import openfl.display.BitmapData;
import openfl.display.Shape;

import openfl.geom.Matrix;

import ale.ui.core.MouseSprite;
import ale.ui.core.Sprite;

import ale.ui.Config;

class Utils
{
    public static function roundSprite(width:Float, height:Float, ?style:RoundStyle):Sprite
        return new Sprite(0, 0, roundGraphic(width, height, style));

    public static function roundMouseSprite(width:Float, height:Float, ?style:RoundStyle):Sprite
        return new MouseSprite(0, 0, roundGraphic(width, height, style));

    public static function roundGraphic(width:Float, height:Float, ?style:RoundStyle):FlxGraphic
    {
        style = resolveStyle(style);

        final size = intAdjust(width, height);

        final bitmap:BitmapData = new BitmapData(size.x, size.y, true, 0x0);

        final matrix:Matrix = new Matrix();
        matrix.createGradientBox(size.x, size.y, Math.PI / 2);

        final shape:Shape = new Shape();
        shape.graphics.beginGradientFill(GradientType.LINEAR, style.gradient, [1, 1], [0, 255], matrix);
        shape.graphics.lineStyle(Config.OUTLINE_SIZE, light(Config.OUTLINE_COLOR, style.color));
        shape.graphics.drawRoundRectComplex(Config.OUTLINE_SIZE / 2, Config.OUTLINE_SIZE / 2, size.x - Config.OUTLINE_SIZE, size.y - Config.OUTLINE_SIZE, style.topLeft * Config.SIZE, style.topRight * Config.SIZE, style.bottomLeft * Config.SIZE, style.bottomRight * Config.SIZE);
        shape.graphics.endFill();
        
        bitmap.draw(shape);

        return FlxGraphic.fromBitmapData(bitmap);
    }

    public static function resolveStyle(style:RoundStyle):RoundStyle
    {
        style ??= {};

        style.color ??= Config.COLOR;

        style.topLeft ??= Config.MARGIN_SIZE;
        style.topRight ??= Config.MARGIN_SIZE;
        style.bottomLeft ??= Config.MARGIN_SIZE;
        style.bottomRight ??= Config.MARGIN_SIZE;

        style.gradient ??= [dark(0.5, style.color), dark(0.7, style.color)];

        return style;
    }


    public static function text(?lab:String = 'Label', ?width:Float, ?size:Float):FlxText
    {
        final text:FlxText = new FlxText(0, 0, width, lab, size);
        text.color = Config.FONT_COLOR;
        text.font = Config.FONT;

        return text;
    }

    public static function label(?lab:String = 'Label', follow:FlxObject):FlxText
    {
        lab ??= 'Label';

        final text:FlxText = text(lab, follow.width, Math.min(follow.width, follow.height) * Config.FONT_SIZE);
        text.alignment = 'center';

        center(text, follow);

        return text;
    }

    public static function center(a:FlxSprite, b:FlxSprite)
    {
        a.x = b.x + b.width / 2 - a.width / 2;
        a.y = b.y + b.height / 2 - a.height / 2;
    }


	public static function lerp(a:Float, b:Float, ratio:Float):Float
		return FlxMath.lerp(a, b, FlxMath.bound(ratio * FlxG.elapsed * 60, 0, 1));


    public static function snap(x:Float, mod:Float):Float
        return Math.round(x / mod) * mod;


    public static function deleteDuplicates(obj:Array<Dynamic>):Array<Dynamic>
    {
        final seen:Map = new Map<Dynamic, Bool>();

        return obj.filter(x -> {
            if (seen.exists(x))
                return false;

            seen.set(x, true);

            return true;
        });
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
            x: width * Config.SIZE,
            y: height * Config.SIZE
        };


    public static function light(percent:Float, ?a:FlxColor):FlxColor
        return mix(FlxColor.WHITE, percent, a);

    public static function dark(percent:Float, ?a:FlxColor):FlxColor
        return mix(FlxColor.BLACK, percent, a);

    public static function gray(percent:Float, ?a:FlxColor):FlxColor
        return mix(FlxColor.GRAY, percent, a);

    public static function mix(b:FlxColor, percent:Float, ?a:FlxColor):FlxColor
        return FlxColor.interpolate(a ?? Config.COLOR, b, percent);
}