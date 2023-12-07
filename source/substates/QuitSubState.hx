package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class QuitSubState extends FlxSubState
{
    public function new()
    {
        super();

        var bg:FlxSprite = new FlxSprite().makeGraphic(720, 720, FlxColor.BLACK);
        bg.alpha = 0.65;
        add(bg);

        var text:FlxText = new FlxText(0, 0, 0, "Quitting?\n\nPress ENTER to return.\nPress ESCAPE to quit game.", 64);
        text.setFormat(Paths.font('vcr.ttf'), 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.screenCenter(XY);
        text.scale.set(2, 2);
        add(text);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
            close();
        else if (FlxG.keys.justPressed.ESCAPE)
            Sys.exit(0);
    }
}