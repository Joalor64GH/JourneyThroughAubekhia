package substates;

class LevelCompleteSubState extends FlxSubState
{
    public function new()
    {
        super();

        var bg:FlxSprite = new FlxSprite().makeGraphic(720, 720, FlxColor.BLACK);
        bg.scrollFactor.set();
        bg.alpha = 0.65;
        add(bg);

        var text:FlxText = new FlxText(0, 0, 0, "Level Complete!\n\nPress ENTER to continue.", 64);
        text.setFormat(Paths.font('vcr'), 35, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.scrollFactor.set();
        text.screenCenter(XY);
        add(text);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
            FlxG.switchState(new states.LevelSelectState());
    }
}