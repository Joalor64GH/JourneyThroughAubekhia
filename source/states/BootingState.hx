package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import util.SaveData;
import util.Localization;

class BootingState extends FlxState
{
    override public function create()
    {
        SaveData.init();
        // Localization.loadLanguages("de", "en", "es", "fr", "it");

        FlxG.switchState(new states.MainMenuState());
        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}