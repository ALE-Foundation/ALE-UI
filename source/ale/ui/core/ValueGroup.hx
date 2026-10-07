package ale.ui.core;

import flixel.util.typeLimit.OneOfTwo;

class ValueGroup<T> extends SpriteGroup
{
    var _uiTarget:Dynamic;
    var _targetProperties:Array<String>;
    var _targetUpdate:T -> Void;

    public var callback:T -> Void;

    public var value(default, set):T;
    function set_value(val:T):T
    {
        value = val;

        updateTarget(value);

        if (callback != null)
            callback(value);

        return val;
    }

    public function updateTarget(value:T):T
    {
        if (_uiTarget != null && _targetProperties != null && _targetUpdate != null)
            _targetUpdate(value);

        return value;
    }

    public function setTarget(obj:Dynamic, props:OneOfTwo<String, Array<String>>, ?sync:Bool = false, ?func:Dynamic -> Void)
    {
        _uiTarget = obj;
        _targetProperties = cast props is Array ? props : [props];
        _targetUpdate = func ?? val -> for (prop in _targetProperties) Reflect.setProperty(_uiTarget, prop, val);

        if (sync)
            syncValue();
    }

    public function syncValue():T
    {
        for (prop in _targetProperties)
        {
            final val = Reflect.getProperty(_uiTarget, prop);

            if (val != value)
                value = val;
        }

        return value;
    }
}