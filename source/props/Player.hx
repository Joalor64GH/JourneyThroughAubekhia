package props;

import flixel.FlxG;
import flixel.FlxSprite;

import utils.Vector;

class Player extends FlxSprite
{
    public var direction:Vector = new Vector(0, 0);
    public var speed:Vector = new Vector(0, 0);

    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic(Paths.image('player'), true, 16, 16);

        animation.add("idle", [0], 1);
        animation.add("walk", [1, 0], 1);
        animation.add("jump", [2, 3], 1);
        animation.add("hurt", [4], 1);
        animation.add("oops", [5], 1);

        animation.play("idle");
    }

    public function turnRight(flip:Bool = true)
    {
        flipX = flip;

        if (this.flipX)
            this.flipX = false;

        return flip;
    }

    public function turnLeft(flip:Bool = false)
    {
        flipX = flip;

        if (!this.flipX)
            this.flipX = false;

        return flip;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        this.x += direction.dx * speed.dx;
        this.y += direction.dy * speed.dy;
    }
}