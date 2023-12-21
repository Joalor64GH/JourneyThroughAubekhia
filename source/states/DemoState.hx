package states;

import flixel.FlxG;
import flixel.FlxState;
import ui.Alphabet;

class DemoState extends FlxState
{
    override public function create()
    {
        var title:Alphabet = new Alphabet(0, 0, "hey you\nthis game is a demo\nwhich mean its not finished yet\npress anything to continue");
        title.screenCenter(XY);
        add(title);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ANY)
            FlxG.switchState(new states.MainMenuState());
    }
}