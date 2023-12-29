package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;

class LanguageSubState extends FlxSubState
{
    public function new()
    {
        super();
    }
}

class Locale extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic(Paths.image('locales'), true, 16, 16);

        animation.add("deutsch", [0], 1);
        animation.add("english", [1], 1);
        animation.add("espanol", [2], 1);
        animation.add("francais", [3], 1);
        animation.add("italiano", [4], 1);
    }
}