package states;

import flixel.FlxG;
import flixel.FlxState;
import ui.Alphabet;

class TestState extends FlxState
{
    override public function create()
    {
        var title:Alphabet = new Alphabet(0, 0, "Swagger");
        title.screenCenter(XY);
        add(title);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new states.MainMenuState());
        }
    }
}