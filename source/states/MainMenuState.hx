package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

class MainMenuState extends FlxState
{
    override public function create()
    {
        var title:FlxText = new FlxText(0, 0, 0, "Journey Through Aubekhia", 12);
        title.setFormat(Paths.font('vcr.ttf'), 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        title.screenCenter(X);
        add(title);

        var button:FlxButton = new FlxButton(0, FlxG.height / 2 + 50, "Level Select", function() 
        {
            FlxG.switchState(new states.FreeplayState());
        });
        button.scale.set(2, 2);
        button.screenCenter(X);
        add(button);

        var daText:FlxText = new FlxText(5, FlxG.height - 24, 0, "Remind me to make a proper main menu later.", 12);
        daText.setFormat(Paths.font('vcr.ttf'), 26, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText.scrollFactor.set();
        add(daText);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new states.PlayState());
        }
    }
}