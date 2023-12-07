package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

import util.SaveData;

// scuffed at the moment, just a copy of freeplay for now
class OptionsState extends FlxState
{
    var options:Array<String> = ["FPS Counter", "FPS Cap", "Language", "Fullscreen"];
    var group:FlxTypedGroup<FlxText>;
    var curSelected:Int = 0;
    var text:FlxText;

    override public function create()
    {
        super.create();

        group = new FlxTypedGroup<FlxText>();
        add(group);

        for (i in 0...options.length)
        {
            var optionTxt:FlxText = new FlxText(20, 20 + (i * 50), 0, options[i], 32);
            optionTxt.ID = i;
            group.add(optionTxt);
        }

        text = new FlxText(0, 20, 0, "", 12);
        text.scrollFactor.set();
        add(text);

        changeSelection();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        switch (options[curSelected])
        {
            case "FPS Counter":
                text.text = FlxG.save.data.fpsCounter;
            case "FPS Cap":
                text.text = FlxG.save.data.fpsCap;
            case "Fullscreen":
                text.text = FlxG.save.data.fullScreen;
            default:
                text.text = "";
        }

        if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
            changeSelection(FlxG.keys.justPressed.UP ? -1 : 1);

        if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new states.MainMenuState());
            FlxG.save.flush();
        }

        if (FlxG.keys.justPressed.ENTER)
        {
            switch (options[curSelected])
            {
                case "FPS Counter":
                    FlxG.save.data.fpsCounter = !FlxG.save.data.fpsCounter;
                case "Fullscreen":
                    FlxG.save.data.fullScreen = !FlxG.save.data.fullScreen;
                    FlxG.fullscreen = FlxG.save.data.fullScreen;
                /*
                case "Language":
                    openSubState(new LanguageSubState());
                */
            }
        }

        if (options[curSelected] == "FPS Cap")
        {
            if (FlxG.keys.justPressed.RIGHT)
                FlxG.save.data.fpsCap += 1;
            else if (FlxG.keys.justPressed.LEFT)
                FlxG.save.data.fpsCap -= 1;
        }
    }

    function changeSelection(change:Int = 0)
    {
        curSelected += change;

        if (curSelected < 0)
            curSelected = group.length - 1;
        if (curSelected >= group.length)
            curSelected = 0;

        switch (options[curSelected])
        {
            case "FPS Counter":
                text.text = FlxG.save.data.fpsCounter;
            case "FPS Cap":
                text.text = FlxG.save.data.fpsCap;
            case "Fullscreen":
                text.text = FlxG.save.data.fullScreen;
            default:
                text.text = "";
        }

        group.forEach(function(txt:FlxText) 
        {
            txt.color = FlxColor.WHITE;

            if (txt.ID == curSelected)
                txt.color = FlxColor.CYAN;
        });
    }
}