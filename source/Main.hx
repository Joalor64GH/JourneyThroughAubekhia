package;

import flixel.FlxG;
import flixel.FlxGame;

import openfl.Lib;
import openfl.display.Sprite;

#if desktop
import openfl.events.UncaughtErrorEvent;

import lime.app.Application;

import haxe.CallStack;
import haxe.io.Path;

import sys.io.File;
import sys.io.Process;
import sys.FileSystem;
#end

import display.ToastCore;
import display.FPS;

using StringTools;

class Main extends Sprite
{
	public static var gameWidth:Int = 720;
	public static var gameHeight:Int = 720;

	public static var toast:ToastCore;

	public function new()
	{
		super();

		addChild(new FlxGame(gameWidth, gameHeight, states.BootingState, #if (flixel < "5.0.0") -1, #end 60, 60, false, false));

		var fps:FPS = new FPS(10, 3, 0xFFFFFF);
		addChild(fps);
		
		if (fps != null && FlxG.save.data.fpsCounter != null)
			fps.visible = FlxG.save.data.fpsCounter;

		#if desktop
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		toast = new ToastCore();
		addChild(toast);
	}

	#if desktop
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "JTA_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error + "\nPlease report this error to the GitHub page: https://github.com/Joalor64GH/JourneyThroughAubekhia\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		Sys.exit(0);
	}
	#end
}