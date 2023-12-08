package states;

import flixel.addons.editors.ogmo.FlxOgmo3Loader;
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

    var hearts:Array<FlxSprite> = [];

    var pointsTxt:FlxText;
    var coinsTxt:FlxText;

    var map:FlxOgmo3Loader;

    public function new()
    {
        super();
    }

    override public function create()
    {
        super.create();

        instance = this;

        var bg:FlxSprite = new FlxSprite().makeGraphic(720, 720, FlxColor.BLUE);
        add(bg);

        var text:FlxText = new FlxText(0, 0, 0, "Hello World", 64);
        text.setFormat(Paths.font('vcr.ttf'), 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.screenCenter(X);
        add(text);

        var player:Player = new Player(0, 0); // for testing
        player.screenCenter(XY);
        add(player);

        for (i in 0...4)
        {
            hearts[i] = new FlxSprite().loadGraphic(Paths.image('hearts'), true, 16, 16);
            hearts[i].scrollFactor.set();
            hearts[i].x += (i - 1) * 90;
            hearts[i].animation.add("heart1", [0], 1);
            hearts[i].animation.add("heart2", [1], 1);
            hearts[i].animation.play("heart1");
            add(hearts[i]);
        }
    }

    function placeEntities(entity:EntityData)
    {
        var x = entity.x;
        var y = entity.y;

        switch (entity.name)
        {
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
        {
            openSubState(new substates.PauseSubState());
        }
    }
}
