import ale.ui.objects.Button;


// IGNORE TS

if (CoolVars.tactile)
{
    CoolUtil.resizeGame(720 / 2, 720);

    MobileAPI.setOrientation('portrait');
} else {
    CoolUtil.resizeGame(850, 500, false);
}

// :3


final button:Button = new Button(2, 1, 'Oso', () -> debugTrace('donde'));
add(button);