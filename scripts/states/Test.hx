import ale.ui.objects.MultiTab;
import ale.ui.objects.Tab;

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


final multitab:MultiTab = new MultiTab(1, 1, ['oso', 'donde', 'ta'], 'ta', 10, 10, 1);
add(multitab);

final button:Button = new Button(1, 1, 'ups', () -> debugTrace('oso'));
multitab.addObj('ta', button);