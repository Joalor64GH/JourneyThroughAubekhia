package states;

import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.FlxState;
import flixel.FlxG;

import props.Coin;
import props.Flag;
import props.Player;

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

    var camHUD:FlxCamera;

    override public function create()
    {
        super.create();

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

        scoreTxt = new FlxText(0, 0, 0, "Score: " + points + "\n" + "Coins: " + coins, 12);
        scoreTxt.setFormat(Paths.font('vcr'), 26, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        scoreTxt.cameras = [camHUD];
        scoreTxt.scrollFactor.set();
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
        FlxG.camera.follow(player, LOCKON, 0.9);

        FlxG.overlap(player, coin, touchCoin);
        FlxG.overlap(player, flag, touchFlag);

        if (FlxG.keys.justPressed.ESCAPE)
        {
            openSubState(new substates.PauseSubState());
            persistentUpdate = false;
        }
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
            FlxG.save.flush();
            FlxG.switchState(new states.MainMenuState());
            flag.animation.play("stop");
        }
    }
}