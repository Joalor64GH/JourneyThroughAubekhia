package props;

import flixel.FlxG;
import flixel.FlxSprite;

class Coin extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);

        loadGraphic(Paths.image('coin'), true, 16, 16);

        animation.add("floating", [0, 1, 2, 1], 12, true);

        animation.play("floating");
    }
}