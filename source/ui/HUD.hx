package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
    var hearts:Array<FlxSprite> = [];
    
    var coinsTxt:FlxText;
    var pointsTxt:FlxText;

    public function new()
    {
        super();

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

    public function updateHUD()
    {
        // doesn't do anything yet
    }
}