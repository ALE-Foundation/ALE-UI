package ale.ui;

interface IObject
{
    public var allowUpdate:Bool;

    public function uiUpdate(elapsed:Float):Void;

    public var allowDraw:Bool;

    public function uiDraw():Void;
}