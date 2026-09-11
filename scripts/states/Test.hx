import ale.ui.objects.Button;
import ale.ui.objects.Tab;


// IGNORE TS

if (CoolVars.tactile)
{
    CoolUtil.resizeGame(720 / 2, 720);

    MobileAPI.setOrientation('portrait');
} else {
    CoolUtil.resizeGame(850, 500, false);
}

// :3

final tab:Tab = new Tab(3, 3, 'Oso', 10, 10, 1);
add(tab);

final button:Button = new Button(1, 1, 'ups', () -> debugTrace('oso'));
tab.add(button);