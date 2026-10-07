package ale.ui.interfaces;

interface IObject
{
    public var brightness(never, set):Float;
    private function set_brightness(value:Float):Float;

    public function place(?uX:Float, ?uY:Float, ?right:Bool = false, ?down:Bool = false):Void;
}