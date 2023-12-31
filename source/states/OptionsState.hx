package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

class OptionsState extends FlxState
{
    var options:Array<String> = ["FPS Counter", "Fullscreen", "Language"];
    
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
            optionTxt.setFormat(Paths.font('vcr'), 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            optionTxt.ID = i;
            group.add(optionTxt);
        }

        text = new FlxText(curSelected + 250, 20, 0, "", 12);
        text.setFormat(Paths.font('vcr'), 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
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
                    Main.fps.visible = FlxG.save.data.fpsCounter;
                case "Fullscreen":
                    FlxG.save.data.fullScreen = !FlxG.save.data.fullScreen;
                    FlxG.fullscreen = FlxG.save.data.fullScreen;
                /*
                case "Language":
                    openSubState(new LanguageSubState());
                */
            }
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