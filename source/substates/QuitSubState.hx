package substates;

class QuitSubState extends FlxSubState
{
    public function new()
    {
        super();

        var bg:FlxSprite = new FlxSprite().makeGraphic(720, 720, FlxColor.BLACK);
        bg.alpha = 0.65;
        add(bg);

        var text:FlxText = new FlxText(0, 0, 0, "Quitting?\n\nPress ENTER to return.\nPress ESCAPE to quit game.", 64);
        text.setFormat(Paths.font('vcr'), 35, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.screenCenter(XY);
        add(text);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
            close();
        else if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.save.flush();
            FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
            {
                Sys.exit(0);
            });
        }
    }
}