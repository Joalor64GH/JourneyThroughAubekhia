package states;

class LevelSelectState extends FlxState
{
    var levels:Array<String> = ["Level 1", "Level 2", "Level 3"]; // for testing
    var group:FlxTypedGroup<FlxText>;
    var curSelected:Int = 0;

    override public function create()
    {
        super.create();

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('bgLevelSelect'));
        add(bg);

        group = new FlxTypedGroup<FlxText>();
        add(group);

        for (i in 0...levels.length)
        {
            var lvlText:FlxText = new FlxText(10, (26 * i) + 30, 0, levels[i], 24);
            lvlText.ID = i;
            group.add(lvlText);
        }

        changeSelection();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
            changeSelection(FlxG.keys.justPressed.UP ? -1 : 1);

        if (FlxG.keys.justPressed.ESCAPE)
            FlxG.switchState(new states.MainMenuState());

        if (FlxG.keys.justPressed.ENTER)
        {
            switch (levels[curSelected])
            {
                case "Level 1":
                    FlxG.switchState(new states.PlayState());
                    
                case "Level 2" | "Level 3":
                    Main.toast.create('Nope.', 0xFFFFFF00, "This isn't finished yet.");
            }
        }
    }

    function changeSelection(change:Int = 0)
    {
        curSelected += change;

        if (curSelected < 0)
            curSelected = group.length - 1;
        if (curSelected >= group.length)
            curSelected = 0;

        group.forEach(function(txt:FlxText) 
        {
            txt.color = (txt.ID == curSelected) ? FlxColor.CYAN : FlxColor.WHITE;
        });
    }
}