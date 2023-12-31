package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class BootingState extends FlxState
{
    override public function create()
    {
        SaveData.init();
        Localization.loadLanguages(["de", "en", "es", "fr", "it"]);

        FlxG.switchState(new states.LevelSelectState());
        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}