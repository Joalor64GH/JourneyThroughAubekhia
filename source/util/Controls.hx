package util;

import flixel.FlxG;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;

class Controls
{
    public var LEFT:FlxKey;
    public var RIGHT:FlxKey;
    public var DOWN:FlxKey;
    public var UP:FlxKey;

    public var ENTER:FlxKey;
    public var SPACE:FlxKey;
    public var ESCAPE:FlxKey;

    // initialize controls
    public static function init():Void
    {
        LEFT = FlxG.keys.LEFT;
        RIGHT = FlxG.keys.RIGHT;
        DOWN = FlxG.keys.DOWN;
        UP = FlxG.keys.UP;

        ENTER = FlxG.keys.ENTER;
        SPACE = FlxG.keys.SPACE;
        ESCAPE = FlxG.keys.ESCAPE;
    } 

    override function update(elapsed:Float)
    {
        LEFT.update();
        RIGHT.update();
        DOWN.update();
        UP.update();

        ENTER.update();
        SPACE.update();
        ESCAPE.update();

        super.update();
    }
}
