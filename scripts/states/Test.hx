import ale.ui.objects.Slider;

// OLD ALE UI SHIT

import ale.ui.UIUtils;

UIUtils.usedInputs = 1;

// IGNORE TS

if (CoolVars.tactile)
{
    CoolUtil.resizeGame(720 / 2, 720);

    MobileAPI.setOrientation('portrait');
} else {
    // CoolUtil.resizeGame(850, 500, false);
}

// :3

final char = new funkin.visuals.game.Character('gf');
char.x += 500;
char.y += 100;
add(char);

final slider = new Slider(1, 1, 0, 5, 1, true, 8, 1, 2, 2, FlxColor.RED);
add(slider);

slider.setTarget(char.scale, ['x', 'y']);