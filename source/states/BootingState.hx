package states;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class BootingState extends FlxState
{
    override public function create()
    {
        SaveData.init();
        Localization.loadLanguages(["de", "en", "es", "fr", "it"]);

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('bgBoot'));
        add(bg);

        var emitter:FlxEmitter = new FlxEmitter();

        for (i in 0...20)
        {
            var p:FlxParticle = new FlxParticle();
            p.loadGraphic(Paths.image('particle'));
            p.exists = false;
            emitter.add(p);
        }

        add(emitter);

        var daText:FlxText = new FlxText(0, 350, 0, "Created by Joalor64\nMade with HaxeFlixel", 12);
        daText.setFormat(Paths.font('vcr'), 50, FlxColor.WHITE, FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        daText.screenCenter(X);
        add(daText);

        var daLogo:FlxSprite = new FlxSprite(0, 500).loadGraphic(Paths.image('haxeflixel'), false, 16, 16);
        daLogo.screenCenter(X);
        daLogo.scale.set(8, 8);
        add(daLogo);

        FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
        emitter.start(false, 0.1, 1);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        new FlxTimer().start(5, function(tmr:FlxTimer)
        {
            FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
            {
                FlxG.switchState(new states.MainMenuState());
            });
        });
    }

    override public function destroy()
    {
        super.destroy();
    }
}