package props;

import flixel.FlxG;
import flixel.FlxSprite;

import util.Vector;

class Player extends FlxSprite
{
    public var direction:Vector = new Vector(0, 0);
    public var speed:Vector = new Vector(150, 0);

    private var remainingJumps:Int = 2;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic(Paths.image('player'), true, 16, 16);

        animation.add("idle", [0], 1);
        animation.add("walk", [1, 0], 12);
        animation.add("jump", [2, 3], 12);
        animation.add("hurt", [4], 1);
        animation.add("oops", [5], 1);
        animation.add("dance", [2, 0], 12);

        animation.play("idle");

        acceleration.y = 420; // nice
        drag.x = 400;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        velocity.x = 0;

        animation.play((velocity.x != 0) ? "walk" : "idle");

        if (FlxG.keys.anyPressed([LEFT, A]))
        {
            velocity.x = -speed.dx;
            turnLeft(true);
        }
        else if (FlxG.keys.anyPressed([RIGHT, D]))
        {
            velocity.x = speed.dx;
            turnRight(false);
        }

        if (FlxG.keys.anyPressed([W, UP, SPACE]) && isTouching(FLOOR)) 
        {
            if (remainingJumps > 0)
            {
                if (!isTouching(FLOOR))
                    remainingJumps--;

                velocity.y = -200;
                animation.play("jump");
            }
        }

        if (isTouching(FLOOR))
            remainingJumps = 2;
    }

    public function turnRight(flip:Bool = true):Bool
    {
        flipX = flip;
        return flip;
    }

    public function turnLeft(flip:Bool = false):Bool
    {
        flipX = flip;
        return flip;
    }
}