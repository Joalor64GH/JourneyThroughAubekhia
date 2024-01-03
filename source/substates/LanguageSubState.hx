package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.Locale;

class LanguageSubState extends FlxSubState
{
    var langList:Array<String> = ["deutsch", "english", "espanol", "francais", "italiano"];
    var daGroup:FlxTypedGroup<FlxSprite>;
    var bg:FlxSprite;

    public function new()
    {
        super();

        var daText:FlxText = new FlxText(5, FlxG.height - 24, 0, "Changing the language will require a game restart!", 12);
        daText.setFormat(Paths.font('vcr'), 26, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText.scrollFactor.set();
        add(daText);
    }
}