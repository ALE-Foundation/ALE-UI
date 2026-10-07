package ale.ui.objects;

import ale.ui.structures.RoundStyle;

import ale.ui.core.MouseSprite;
import ale.ui.core.Text;

import ale.ui.Utils;

class CheckBox extends ale.ui.core.SpriteGroup
{
    var button:MouseSprite;
    var label:Text;

    public var callback:Bool -> Void;

    public var disabled(default, set):Bool;
    function set_disabled(val:Bool):Bool
    {
        disabled = val;

        if (disabled)
            brightness = -0.5;
        else
            brightness = value ? 0.5 : 0;

        return disabled;
    }
    
    public var value(default, set):Bool;
    function set_value(val:Bool):Bool
    {
        value = val;

        brightness = value ? 0.5 : 0;

        updateTarget(value);

        if (callback != null)
            callback(value);
        
        return value;
    }

    public function new(?x:Float, ?y:Float, ?lab:String = 'CheckBox', ?width:Int = 1, ?height:Int = 1, ?style:RoundStyle)
    {
        super(x, y);

        button = Utils.roundMouseSprite(width, height, style);
        button.onPressChange = pressed -> if (!disabled)
        {
            if (pressed)
                button.brightness = -0.25;
            else
                value = !value;
        }
        add(button);

        label = Utils.text(lab, 0, button.height * (1 - Config.MARGIN_SIZE));
        label.x = button.width + Config.MARGIN;
        add(label);
    }
}