import ale.ui.objects.Button;

CoolUtil.resizeGame(720 / 2, 720);

MobileAPI.setOrientation('portrait');

FlxG.mouse.useSystemCursor = false;

final button:Button = new Button(100, 100, 'Peppino', () -> debugTrace('oso'));
//button.disabled = true;
add(button);