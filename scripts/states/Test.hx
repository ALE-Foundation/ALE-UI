import ale.ui.objects.Tab;

// OLD ALE UI SHIT

import ale.ui.UIUtils;

UIUtils.usedInputs = 1;

// IGNORE TS

if (CoolVars.tactile)
{
    CoolUtil.resizeGame(720 / 2, 720);

    MobileAPI.setOrientation('portrait');
} else {
    CoolUtil.resizeGame(850, 500, false);
}

// :3

final obj = new Tab();
add(obj);