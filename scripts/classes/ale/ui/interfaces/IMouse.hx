package ale.ui.interfaces;

interface IMouse
{
    public var overlaped:Bool;
    public var onOverlapedChange:Bool -> Void;

    public var pressed:Bool;
    public var onPressChange:Bool -> Void;

    public var pressCallback:Void -> Void;
    public var releaseCallback:Void -> Void;

    public function overlapCallbackHandler(isOver:Bool):Void;

    public function pressCallbackHandler(isPressed:Bool):Void;
}