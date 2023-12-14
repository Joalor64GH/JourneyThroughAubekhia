package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import lime.app.Application;

class MainMenuState extends FlxState
{
    var logo:FlxSprite;

    override public function create()
    {
        logo = new FlxSprite(0, 50).loadGraphic(Paths.image('logo'));
        logo.screenCenter(X);
        logo.scale.set(2, 2);
        add(logo);

        logoTween();

        var button:FlxButton = new FlxButton(0, FlxG.height / 2 + 50, "Level Select", function() 
        {
            FlxG.switchState(new states.LevelSelectState());
        });
        button.scale.set(2, 2);
        button.screenCenter(X);
        add(button);

        var button2:FlxButton = new FlxButton(0, button.y + 50, "Options", function() 
        {
            FlxG.switchState(new states.OptionsState());
        });
        button2.scale.set(2, 2);
        button2.screenCenter(X);
        add(button2);

        var button3:FlxButton = new FlxButton(0, button2.y + 50, "Quit", function() 
        {
            #if (desktop || sys)
            openSubState(new substates.QuitSubState());
            #elseif html5
            Main.toast.create('Hey!', 0xFFFFFF00, "You can't do this on web!");
            #end
        });
        button3.scale.set(2, 2);
        button3.screenCenter(X);
        add(button3);

        var daText:FlxText = new FlxText(5, FlxG.height - 44, 0, "Remind me to make a proper main menu later.", 12);
        daText.setFormat(Paths.font('vcr.ttf'), 26, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText.scrollFactor.set();
        add(daText);

        var versionTxt:FlxText = new FlxText(5, FlxG.height - 24, 0, "v" + Application.current.meta.get("version"), 12);
        versionTxt.setFormat(Paths.font('vcr'), 26, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        versionTxt.scrollFactor.set();
        add(versionTxt);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }

    function logoTween()
    {
        logo.angle = -4;

        new FlxTimer().start(0.01, function(tmr:FlxTimer) 
        {
            if (logo.angle == -4)
                FlxTween.angle(logo, logo.angle, 4, 4, {ease: FlxEase.quartInOut});
            if (logo.angle == 4)
                FlxTween.angle(logo, logo.angle, -4, 4, {ease: FlxEase.quartInOut});
        }, 0);
    }
}