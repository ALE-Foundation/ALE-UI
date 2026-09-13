package ale.ui.objects;

import ale.ui.Utils;

class Button extends ale.ui.objects.MouseSpriteGroup
{
    var bg:FlxSprite;
    var label:FlxText;

	public var disabled(default, set):Bool;
	public function set_disabled(value:Bool):Bool
	{
		if (disabled == value)
			return disabled;

		brightness = value ? -0.5 : 0;
		
		return disabled = value;
	}

	public var callback:Void -> Void;
    
    public function new(?x:Float, ?y:Float, ?text:String = 'Button', ?callback:Void -> Void, ?width:Float = 4, ?height:Int = 1, ?color:FlxColor)
    {
        super(x, y);

		text ??= 'Button';
		
		width ??= 4;
		height ??= 1;

        bg = Utils.roundSprite(width, height, color);

        label = Utils.label(text, bg);
		
        add(bg);
        add(label);

		this.callback = callback;
    }

	override function overlapCallbackHandler(over:Bool):Bool
	{
		if (disabled)
			return;
		
		brightness = over ? 0.25 : 0;
		
		super.overlapCallbackHandler(over);
	}

	override function pressCallbackHandler(pressed:Bool)
	{
		if (disabled)
			return;
		
		brightness = pressed ? -0.25 : 0;
		
		super.pressCallbackHandler(pressed);

		if (!pressed && callback != null)
			callback();
	}
}