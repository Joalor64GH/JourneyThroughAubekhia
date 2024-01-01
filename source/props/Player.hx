package props;

import flixel.FlxG;
import flixel.FlxSprite;

import util.Vector;

class Player extends FlxSprite
{
    public var speed:Vector = new Vector(150, 0);

    var jumpTimer:Float = 0;
    var jumping:Bool = false;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic(Paths.image('player'), true, 16, 16);

        animation.add("idle", [0], 1);
        animation.add("walk", [1, 0], 12);
        animation.add("jump", [3], 12);
        animation.add("hurt", [4], 1);
        animation.add("oops", [5], 1);
        animation.add("dance", [2, 0], 12);
        animation.play("idle");

        acceleration.y = 900;
        maxVelocity.y = 300;
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

        if (jumping && !FlxG.keys.anyJustPressed([W, UP, SPACE]))
            jumping = false;

        if (isTouching(DOWN) && !jumping) 
            jumpTimer = 0;

        if (FlxG.keys.anyJustPressed([W, UP, SPACE]) && jumpTimer >= 0)
        {
            jumping = true;
            jumpTimer += elapsed;
            animation.play("jump");
        }
        else
            jumpTimer = -1;

        if (jumpTimer > 0 && jumpTimer < 0.25)
            velocity.y = -300;
    }

    function turnRight(flip:Bool = true):Bool
    {
        flipX = flip;
        return flip;
    }

    function turnLeft(flip:Bool = false):Bool
    {
        flipX = flip;
        return flip;
    }
}