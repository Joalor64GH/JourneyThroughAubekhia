package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class FreeplayState extends FlxState
{
    var levels:Array<String> = ["Level 1", "Level 2", "Level 3"];

    var selector:FlxText;
    var curSelected:Int = 0;

    override public function create()
    {
        super.create();

        for (i in 0...levels.length)
        {
            var lvlText:FlxText = new FlxText(10, (26 * i) + 30, 0, levels[i], 24);
            add(lvlText);
        }

        selector = new FlxText();
        selector.size = 24;
        selector.text = ">";
        add(selector);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.UP)
            curSelected -= 1;
        else if (FlxG.keys.justPressed.DOWN)
            curSelected += 1;

        if (FlxG.keys.justPressed.ESCAPE)
            FlxG.switchState(new states.MainMenuState());

        if (curSelected < 0)
            curSelected = levels.length - 1;

        if (curSelected >= levels.length)
            curSelected = 0;

        selector.y = (26 * curSelected) + 30;
    }
}