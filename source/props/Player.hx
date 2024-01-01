package props;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
    public var speed:Float = 150;

    var jumpImpulse:Float = -500;
    var gravity:Float = 900;

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

        acceleration.y = gravity;
        maxVelocity.y = 300;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        velocity.x = FlxG.keys.anyPressed([RIGHT, D]) ? speed : FlxG.keys.anyPressed([LEFT, A]) ? -speed : 0;

        animation.play((velocity.x != 0) ? "walk" : "idle");

        if (isTouching(DOWN) && FlxG.keys.anyJustPressed([W, UP, SPACE]))
        {
            velocity.y = jumpImpulse;
            animation.play("jump");
        }

        if (!isTouching(DOWN))
            velocity.y += gravity * elapsed;
        else
            velocity.y = 0;

        velocity.y = util.CoolUtil.clamp(velocity.y, -maxVelocity.y, maxVelocity.y);
    }
}
