package;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;

class PlayState extends FlxState
{
    override public function create()
    {
        super.create();

        var text:FlxText = new FlxText(0, 0, 0, "Hello World", 64);
        text.screenCenter();
        add(text);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}