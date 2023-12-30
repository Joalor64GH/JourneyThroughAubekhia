package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSubState;

class DialogueSubState extends FlxSubState // will add portraits later
{
    var box:FlxSprite;

    var dialogue:Array<String> = [];
    var diaTxt:FlxText;
    var curLine:Int = 0;

    public function new(dialogue:Array<String> = [])
    {
        super();

        this.dialogue = dialogue;
        createDialogueBox();
        nextLine();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE)
        {
            if (curLine < dialogue.length - 1)
                nextLine();
            else
                closeDialogue();
        }
        else if (FlxG.keys.justPressed.ENTER) // skip dialogue
            closeDialogue();
    }

    function createDialogueBox()
    {
        box = new FlxSprite(20, FlxG.height - 120).makeGraphic(FlxG.width - 40, 100, FlxColor.BLACK);
        add(box);

        diaTxt = new FlxText(box.x + 10, box.y + 10, box.width - 20, "", 12);
        diaTxt.setFormat(Paths.font('vcr'), 12, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(dialogue);
    }

    function nextLine()
    {
        if (curLine < dialogue.length)
        {
            diaTxt.text = dialogue[curLine];
            curLine++;
        }
    }

    function closeDialogue()
    {
        curLine = 0;
        diaTxt.text = "";
        this.kill();
    }
}