package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.Locale;

class LanguageSubState extends FlxSubState
{
    public function new()
    {
        super();

        var daText:FlxText = new FlxText(5, FlxG.height - 24, 0, "Changing the language will require a game restart!", 12);
        daText.setFormat(Paths.font('vcr'), 26, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText.scrollFactor.set();
        add(daText);
    }
}