package util;

import flixel.FlxG;

class SaveData
{
    public static function init()
    {
        if (FlxG.save.data.fpsCounter == null)
            FlxG.save.data.fpsCounter = true;

        if (FlxG.save.data.fpsCap == null)
            FlxG.save.data.fpsCap = 60;
        
        if (FlxG.save.data.lang == null)
            FlxG.save.data.lang = 'en';

        if (FlxG.save.data.fullScreen == null)
            FlxG.save.data.fullScreen = false;
        
        if (FlxG.save.data.coins == null)
            FlxG.save.data.coins = 0;

        if (FlxG.save.data.points == null)
            FlxG.save.data.points = 0;

        FlxG.save.bind('unreleased', 'joalor64');
    }
}