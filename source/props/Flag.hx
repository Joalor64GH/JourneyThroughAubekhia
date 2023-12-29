package props;

import flixel.FlxG;
import flixel.FlxSprite;

class Flag extends FlxSprite
{
    public static var flagSuffix:String = "AB"; // for future use

    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);

        loadGraphic(Paths.image('flag-' + flagSuffix), true, 16, 16);

        animation.add("wave", [1, 2, 3, 4, 5, 0], 12, true);
        animation.add("stop", [0], 12, true);
        animation.play("wave");
    }
}