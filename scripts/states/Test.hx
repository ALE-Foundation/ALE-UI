import ale.ui.objects.NumericStepper;

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

final stepper:NumericStepper = new NumericStepper(1, 1, 0, 100, 2, 1, 'oso', 3, 1, 1, FlxColor.RED);
add(stepper);