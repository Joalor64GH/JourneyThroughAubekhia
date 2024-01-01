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
import flixel.group.FlxGroup.FlxTypedGroup;
import lime.app.Application;

import ui.MenuButton;

class MainMenuState extends FlxState
{
    var logo:FlxSprite;

    var groupBtn:FlxTypedGroup<FlxSprite>;
    var btnList:Array<String> = ["play", "options", "quit"];
    var curSelected:Int = 0;

    override public function create()
    {
        logo = new FlxSprite(0, 60).loadGraphic(Paths.image('logo'));
        logo.screenCenter(X);
        logo.scale.set(2, 2);
        add(logo);

        logoTween();

        groupBtn = new FlxTypedGroup<FlxSprite>();
        add(groupBtn);

        for (i in 0...btnList.length)
        {
            var sepX:Float = 16.0;
            var button:MenuButton = new MenuButton(i * (button.width + sepX), 0);
            button.screenCenter(XY);
            button.ID = i;
            groupBtn.add(button);
        }

        var versionTxt:FlxText = new FlxText(5, FlxG.height - 24, 0, "v" + Application.current.meta.get("version"), 12);
        versionTxt.setFormat(Paths.font('vcr'), 26, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        versionTxt.scrollFactor.set();
        add(versionTxt);

        changeSelection();

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        groupBtn.forEach(function(spr:FlxSprite)
        {
            switch (curSelected)
            {
                case 0:
                    spr.animation.play((FlxG.mouse.overlaps(spr)) ? "playS" : "playU");
                case 1:
                    spr.animation.play((FlxG.mouse.overlaps(spr)) ? "optionsS" : "optionsU");
                case 2:
                    spr.animation.play((FlxG.mouse.overlaps(spr)) ? "quitS" : "quitU");
            }

            spr.updateHitbox();
        });

        changeSelection((FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN) ? -1 : 1);

        groupBtn.forEach(function(spr:FlxSprite)
        {
            if (FlxG.keys.justPressed.ENTER || FlxG.mouse.overlaps(spr) && FlxG.mouse.pressed)
            {
                switch (btnList[curSelected])
                {
                    case "play":
                        FlxG.switchState(new states.LevelSelectState());
                        spr.animation.play("playP");
                    case "options":
                        FlxG.switchState(new states.OptionsState());
                        spr.animation.play("optionsP");
                    case "quit":
                        #if (desktop || sys)
                        openSubState(new substates.QuitSubState());
                        spr.animation.play("quitP");
                        #elseif html5
                        Main.toast.create('Hey!', 0xFFFFFF00, "You can't do this on web!");
                        #end
                }
            }
        });
    }

    function changeSelection(change:Int = 0)
    {
        curSelected += change;

        if (curSelected < 0)
            curSelected = groupBtn.length -1;
        if (curSelected >= groupBtn.length)
            curSelected = 0;
        
        groupBtn.forEach(function(spr:FlxSprite)
        {
            switch (curSelected)
            {
                case 0:
                    spr.animation.play((FlxG.mouse.overlaps(spr)) ? "playS" : "playU");
                case 1:
                    spr.animation.play((FlxG.mouse.overlaps(spr)) ? "optionsS" : "optionsU");
                case 2:
                    spr.animation.play((FlxG.mouse.overlaps(spr)) ? "quitS" : "quitU");
            }

            spr.updateHitbox();
        });
    }

    private function logoTween()
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