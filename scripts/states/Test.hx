import ale.ui.objects.InputText;
import ale.ui.objects.Button;

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

final input = new InputText(null, null, null, 'Masha');
add(input);

final button = new Button(0, 2);
add(button);