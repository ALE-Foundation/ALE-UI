package ale.ui.objects;

import ale.ui.objects.SpriteGroup;
import ale.ui.objects.Tab;

import ale.ui.Utils;

class MultiTab extends Tab
{
    var buttons:Map<String, SpriteGroup> = new Map<String, SpriteGroup>();

    var _groups:Map<String, SpriteGroup> = new Map<String, SpriteGroup>();

    public var current(default, set):String;
    function set_current(value:String)
    {
        for (id in _groups.keys())
        {
            buttons.get(id).brightness = id == value ? 0 : -0.25;

            final grp = _groups.get(id);

            grp.active = grp.visible = id == value;
        }

        return current = value;
    }

    public var disabled(default, set):Bool;
    function set_disabled(value:Bool)
    {
        if (value == disabled)
            return disabled;

        if (!value)
            current = current;

        brightness = value ? -0.5 : 0;

        return disabled = value;
    }
    
    public function new(?x:Float, ?y:Float, ?groups:Array<String>, ?def:String, ?width:Float = 8, ?height:Float = 6, ?borderHeight:Float = 1, ?color:FlxColor)
    {
        super(x, y, '', width, height, borderHeight, color);

        groups ??= ['A', 'B', 'C'];

        width ??= 8;
        height ??= 6;
        borderHeight ??= 1;

        groups = Utils.deleteDuplicates(groups);

        for (index => id in groups)
        {
            if (_groups.exists(id))
                continue;

            final grp:SpriteGroup = new SpriteGroup();
            grp.place(index * width / groups.length, -borderHeight);
            add(grp);

            final but:MouseSprite = Utils.roundMouseSprite(width / groups.length, borderHeight, null, index <= 0, index >= groups.length - 1, false, false, [Utils.dark(0.25, color), Utils.dark(0.5, color)]);
            but.onPressChange = p -> if (!disabled && !p) current = id;

            final tit:FlxText = Utils.label(id, but);

            grp.add(but);
            grp.add(tit);

            buttons.set(id, grp);

            final _grp:SpriteGroup = new SpriteGroup();
            add(_grp);
            
            _groups.set(id, _grp);
        }

        current = def ?? groups[0];
    }

    public function addObj(grp:String, obj:FlxSprite):FlxSprite
        return getGroup(grp)?.add(obj);

    public function removeObj(grp:String, obj:FlxSprite, ?splice:Bool):FlxSprite
        return getGroup(grp)?.remove(obj, splice);

    public function insertObj(grp:String, index:Int, obj:FlxSprite):FlxSprite
        return getGroup(grp)?.insert(index, obj);

    public function getGroup(id:String):String
        return _groups.get(id);
}