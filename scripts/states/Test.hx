import ale.ui.objects.Button;

if (CoolVars.tactile)
{
    CoolUtil.resizeGame(720 / 2, 720);

    MobileAPI.setOrientation('portrait');
} else {
    CoolUtil.resizeGame(850, 500, false);
}


final button:Button = new Button(100, 100, null, () -> debugTrace('oso'));
add(button);