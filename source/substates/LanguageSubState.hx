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

        var bg:FlxSprite = new FlxSprite().makeGraphic(720, 720, FlxColor.BLACK);
        bg.scrollFactor.set();
        add(bg);

        var daText:FlxText = new FlxText(0, 0, 0, "Language", 12);
        daText.setFormat(Paths.font('vcr'), 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText.scrollFactor.set();
        daText.screenCenter(X);
        add(daText);

        var daText2:FlxText = new FlxText(5, FlxG.height - 24, 0, "Changing the language will require a game restart!", 12);
        daText2.setFormat(Paths.font('vcr'), 15, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText2.scrollFactor.set();
        add(daText2);
    }
}