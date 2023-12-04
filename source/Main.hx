package;

import flixel.FlxG;
import flixel.FlxGame;

import openfl.display.Sprite;

class Main extends Sprite
{
	public static var gameWidth:Int = 720;
	public static var gameHeight:Int = 720;

	public function new()
	{
		super();

		addChild(new FlxGame(gameWidth, gameHeight, states.PlayState, #if (flixel < "5.0.0") -1, #end 60, 60, false, false));
		addChild(new display.FPS(10, 3, 0xFFFFFF));
	}
}