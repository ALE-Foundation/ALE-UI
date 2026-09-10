package ale.ui;

interface IObject
{
    public var allowUpdate:Bool;

    public function uiUpdate(elapsed:Float):Void;

    public var allowDraw:Bool;

    public function uiDraw():Void;

    public function place(?uX:Float, ?uY:Float, ?right:Bool = false, ?down:Bool = false):Void;
}