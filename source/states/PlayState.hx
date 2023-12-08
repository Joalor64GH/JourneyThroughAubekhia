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

    var pointsTxt:FlxText;
    var coinsTxt:FlxText;

    var map:FlxOgmo3Loader;
    var walls:FlxTilemap;

    var player:Player;
    var coin:FlxTypedGroup<Coin>;
    var flag:Flag;

    override public function create()
    {
        super.create();

        instance = this;

        FlxG.camera.zoom = 2.25;

        var bg:FlxSprite = new FlxSprite().makeGraphic(720, 720, FlxColor.BLUE);
        add(bg);

        map = new FlxOgmo3Loader(Paths.file('data/level.ogmo'), Paths.json('levels/lev1'));
        walls = map.loadTilemap(Paths.image('tilemap_1'), 'walls');
        walls.follow();
        walls.setTileProperties(1, NONE);
        walls.setTileProperties(2, ANY);
        add(walls);

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

        FlxG.collide(player, walls);
        FlxG.camera.follow(player, LOCKON);

        if (FlxG.keys.justPressed.ESCAPE)
            openSubState(new substates.PauseSubState());
    }
}