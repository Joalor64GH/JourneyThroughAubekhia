package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

class FreeplayState extends FlxState
{
    var levels:Array<String> = ["Level 1", "Level 2", "Level 3"]; // for testing
    var group:FlxTypedGroup<FlxText>;
    var curSelected:Int = 0;

    override public function create()
    {
        super.create();

        group = new FlxTypedGroup<FlxText>();
        add(group);

        for (i in 0...levels.length)
        {
            var lvlText:FlxText = new FlxText(10, (26 * i) + 30, 0, levels[i], 24);
            lvlText.ID = i;
            group.add(lvlText);
        }

        changeSelection();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
            changeSelection(FlxG.keys.justPressed.UP ? -1 : 1);

        if (FlxG.keys.justPressed.ESCAPE)
            FlxG.switchState(new states.MainMenuState());
    }

    function changeSelection(change:Int = 0)
    {
        curSelected += change;

        if (curSelected < 0)
            curSelected = group.length - 1;
        if (curSelected >= group.length)
            curSelected = 0;

        group.forEach(function(txt:FlxText) 
        {
            txt.color = FlxColor.WHITE;

            if (txt.ID == curSelected)
                txt.color = FlxColor.CYAN;
        });
    }
}