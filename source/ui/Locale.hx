package ui;

import flixel.FlxSprite;

class Locale extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic(Paths.image('locales'), true, 16, 16);

        animation.add("deutsch", [0], 1); // german (germany)
        animation.add("english", [1], 1); // english (united states)
        animation.add("espanol", [2], 1); // spanish (spain)
        animation.add("francais", [3], 1); // french (france)
        animation.add("italiano", [4], 1); // italian (italy)
    }
}