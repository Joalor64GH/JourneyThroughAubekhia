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
        
        /*
        if (FlxG.save.data.lang == null)
            FlxG.save.data.lang = 'en-us';
        */

        if (FlxG.save.data.fullScreen == null)
            FlxG.save.data.fullScreen = false;

        FlxG.save.bind('unreleased', 'joalor64');
    }
}