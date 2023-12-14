package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class BootingState extends FlxState
{
    override public function create()
    {
        SaveData.init();
        Controls.init();

        Localization.loadLanguages(["de", "en", "es", "fr", "it"]);

        FlxG.switchState(new states.DemoState());
        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}