package props;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic(Paths.image('player'), true, 16, 16);

        animation.add("idle", [0], 1);
        animation.add("walk", [1, 0], 1);
        animation.add("jump", [2, 3], 1);
        animation.add("hurt", [4], 1);
        animation.add("oops", [5], 1);
    }
}