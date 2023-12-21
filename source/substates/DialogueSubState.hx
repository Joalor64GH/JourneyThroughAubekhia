package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSubState;

class DialogueSubState extends FlxSubState
{
    var box:FlxSprite;
    var bg:FlxSprite;

    var dialogue:Array<String> = [];
    var diaTxt:FlxText;

    public function new(dialogue:Array<String> = [])
    {
        super();

        this.dialogue = dialogue;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}