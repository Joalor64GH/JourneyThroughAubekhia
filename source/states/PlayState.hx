package states;

import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

import props.Coin;
import props.Flag;
import props.Player;

class PlayState extends FlxState
{
    public static var instance:PlayState = null;

    public function new()
    {
        super();
    }

    override public function create()
    {
        super.create();

        instance = this;

        var text:FlxText = new FlxText(0, 0, 0, "Hello World", 64);
        text.screenCenter();
        add(text);

        var player:Player = new Player(0, 0); // for testing
        player.screenCenter(X);
        add(player);
    }

    function placeEntities(entity:EntityData)
    {
        var x = entity.x;
        var y = entity.y;

        switch (entity.name)
        {
            case "player":
                player.setPosition(x, y);

        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new states.MainMenuState());
        }
    }
}