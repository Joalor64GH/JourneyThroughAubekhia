package states;

import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

import props.Coin;
import props.Flag;
import props.Player;
import props.Spike;

class PlayState extends FlxState
{
    public static var instance:PlayState = null;

    public var points:Int = FlxG.save.data.points;
    public var coins:Int = FlxG.save.data.coins;

    var scoreTxt:FlxText;

    var map:FlxOgmo3Loader;
    var walls:FlxTilemap;

    var player:Player;
    var coin:FlxTypedGroup<Coin>;
    var flag:Flag;
    var spike:Spike;

    override public function create()
    {
        super.create();

        instance = this;

        var bg:FlxSprite = new FlxSprite().makeGraphic(720, 720, FlxColor.BLUE);
        add(bg);

        map = new FlxOgmo3Loader(Paths.file('data/level.ogmo'), Paths.json('levels/lev1'));
        walls = map.loadTilemap(Paths.image('tilemap_1'), 'walls');
        walls.follow();
        walls.setTileProperties(1, NONE);
        walls.setTileProperties(2, ANY);
        add(walls);

        scoreTxt = new FlxText(5, FlxG.height - 24, 0, "Score: " + points + " - " + "Coins: " + coins, 12);
        scoreTxt.setFormat(Paths.font('vcr'), 26, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(scoreTxt);

        coin = new FlxTypedGroup<Coin>();
        add(coin);

        flag = new Flag();
        add(flag);

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
                player.setPosition(x, y);
            case "coin":
                coin.add(new Coin(x, y));
            case "flag":
                flag.x = x;
                flag.y = y;
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        scoreTxt.text = "Score: " + points + "\n" + "Coins: " + coins;

        FlxG.collide(player, walls);
        FlxG.camera.follow(player, PLATFORMER);

        FlxG.overlap(player, coin, touchCoin);
        FlxG.overlap(player, flag, touchFlag);

        if (FlxG.keys.justPressed.ESCAPE)
        {
            openSubState(new substates.PauseSubState());
            persistentUpdate = false;
        }

        if (FlxG.keys.justPressed.R)
            FlxG.resetState();
    }

    function touchCoin(player:Player, coin:Coin)
    {
        if (player.alive && player.exists && coin.alive && coin.exists)
        {
            points += 50;
            coins += 1;
            coin.kill();
        }
    }

    function touchFlag(player:Player, flag:Flag)
    {
        if (player.alive && player.exists && flag.alive && flag.exists)
        {
            points += 1000;
            FlxG.save.flush();
            FlxG.switchState(new states.LevelSelectState());
            flag.animation.play("stop");
        }
    }
}