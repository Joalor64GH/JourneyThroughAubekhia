package props;

import flixel.FlxG;
import flixel.FlxSprite;
import util.Vector;

class Player extends FlxSprite
{
    public var speed:Vector = new Vector(150, 0);

    var jumpTimer:Float = 0;
    var jumping:Bool = false;
    var jumpDuration:Float = 0.25;
    var jumpImpulse:Float = -500;
    var gravityAdjustment:Float = 300;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic(Paths.image('player'), true, 16, 16);

        animation.add("idle", [0], 1);
        animation.add("walk", [1, 0], 12);
        animation.add("jump", [3], 0);
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

        var right:Bool = FlxG.keys.anyPressed([RIGHT, D]);
        var left:Bool = FlxG.keys.anyPressed([LEFT, A]);
        var up:Bool = FlxG.keys.anyJustPressed([W, UP, SPACE]);
        var upHold:Bool = FlxG.keys.anyJustPressed([W, UP, SPACE]);

        if (left)
        {
            velocity.x = -speed.dx;
            turnLeft(true);
            if (!jumping)
                animation.play("walk");
        }
        else if (right)
        {
            velocity.x = speed.dx;
            turnRight(false);
            if (!jumping)
                animation.play("walk");
        }
        else 
        {
            if (!jumping)
                animation.play("idle");
        }

        if (isTouching(DOWN) && !jumping) 
            jumpTimer = 0;

        if (up && isTouching(DOWN))
        {
            velocity.y = jumpImpulse;
            jumpTimer = 0;
            jumping = true;
            animation.play("jump", true);
        }

        if (jumping && jumpTimer >= 0 && jumpTimer < jumpDuration && upHold)
        {
            jumpTimer += elapsed;
            velocity.y = jumpImpulse + (gravityAdjustment * jumpTimer * jumpTimer);
        }
        else 
        {
            jumpTimer = -1;
            jumping = false;
        }
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