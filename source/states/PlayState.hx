package states;

import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSubState;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

import props.Coin;
import props.Flag;
import props.Player;
import props.Spike;

class PlayState extends FlxState
{
    public var points:Int = FlxG.save.data.points;

    public static var instance:PlayState;

    var scoreTxt:FlxText;

    var map:FlxOgmo3Loader;
    var walls:FlxTilemap;

    var player:Player;
    var coin:FlxTypedGroup<Coin>;
    var flag:Flag;
    var spike:Spike;

    var jumpTimer:Float = 0;
    var jumping:Bool = false;

    var camHUD:FlxCamera;

    override public function create()
    {
        super.create();

        openfl.system.System.gc();

        instance = this;

        camHUD = new FlxCamera();
        camHUD.bgColor = 0;
        FlxG.cameras.add(camHUD, false);

        FlxG.camera.zoom = 2.25;

        var bg:FlxSprite = new FlxSprite().makeGraphic(720, 720, FlxColor.BLUE);
        bg.scrollFactor.set();
        add(bg);

        map = new FlxOgmo3Loader(Paths.file('data/level.ogmo'), Paths.json('levels/lev1'));
        walls = map.loadTilemap(Paths.image('tilemap_1'), 'walls');
        walls.follow();
        walls.setTileProperties(1, NONE);
        walls.setTileProperties(2, ANY);
        add(walls);

        scoreTxt = new FlxText(10, 10, 0, "Score: " + points, 12);
        scoreTxt.setFormat(Paths.font('vcr'), 26, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        scoreTxt.scrollFactor.set();
        scoreTxt.cameras = [camHUD];
        add(scoreTxt);

        coin = new FlxTypedGroup<Coin>();
        add(coin);

        flag = new Flag();
        add(flag);

        spike = new Spike();
        add(spike);

        map.loadEntities(placeEntities, 'entity');
    }

    function placeEntities(entity:EntityData)
    {
        var x = entity.x;
        var y = entity.y;

        switch (entity.name)
        {
            case "player":
                add(player = new Player(x, y));
                player.maxVelocity.y = 300;
                player.acceleration.y = 900;
                player.setPosition(x, y);
            case "coin":
                coin.add(new Coin(x, y));
            case "flag":
                flag.x = x;
                flag.y = y;
            case "spike":
                spike.x = x;
                spike.y = y;
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        scoreTxt.text = "Score: " + points;

        FlxG.collide(player, walls);
        FlxG.camera.follow(player, PLATFORMER);

        FlxG.overlap(player, coin, touchCoin);
        FlxG.overlap(player, flag, touchFlag);
        FlxG.overlap(player, spike, touchSpike);

        player.animation.play((player.velocity.x != 0) ? "walk" : "idle");
        player.velocity.x = (FlxG.keys.anyPressed([LEFT, A])) ? -150 : (FlxG.keys.anyPressed([RIGHT, D])) ? 150 : 0;

        if (player.velocity.x != 0)
            player.flipX = player.velocity.x < 0;

        if (jumping && !FlxG.keys.anyJustPressed([W, UP, SPACE]))
            jumping = false;

        if (player.isTouching(DOWN) && !jumping)
            jumpTimer = 0;

        if (jumpTimer >= 0 && FlxG.keys.anyJustPressed([W, UP, SPACE]))
        {
            jumping = true;
            jumpTimer += elapsed;
        }
        else
            jumpTimer = -1;

        if (jumpTimer > 0 && jumpTimer < 0.25)
            player.velocity.y = -300;

        if (FlxG.keys.anyJustPressed([P, ESCAPE]))
        {
            openSubState(new substates.PauseSubState());
            persistentUpdate = false;
        }

        if (FlxG.keys.justPressed.R)
            FlxG.resetState();
    }

    override public function destroy()
    {
        instance = null;

        coin = null;
        flag = null;
        player = null;
        spike = null;

        super.destroy();
    }

    function touchCoin(player:Player, coin:Coin)
    {
        if (player.alive && player.exists && coin.alive && coin.exists)
        {
            points += 50;
            coin.kill();
            FlxG.save.flush();
        }
    }

    function touchFlag(player:Player, flag:Flag)
    {
        if (player.alive && player.exists && flag.alive && flag.exists)
        {
            points += 1000;
            FlxG.save.flush();
            openSubState(new substates.LevelCompleteSubState());
            persistentUpdate = true;
            flag.animation.play("stop");
        }
    }

    function touchSpike(player:Player, spike:Spike)
    {
        if (player.alive && player.exists && spike.alive && spike.exists)
        {
            FlxG.resetState();
        }
    }
}