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

final tex = new FlxText(0, 0, 0, 'oso', 50);
add(tex);

final input = new InputText(3, 3);
input.setTarget(tex, 'text');
add(input);