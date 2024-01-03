package props;

class Flag extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);

        loadGraphic(Paths.image('flag-AB'), true, 16, 16);

        animation.add("wave", [1, 2, 3, 4, 5, 0], 12, true);
        animation.add("stop", [0], 12, true);
        animation.play("wave");
    }
}

class Flag2 extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);

        loadGraphic(Paths.image('flag-QL'), true, 16, 16);

        animation.add("wave", [1, 2, 3, 4, 5, 0], 12, true);
        animation.add("stop", [0], 12, true);
        animation.play("wave");
    }
}