package substates;

class DialogueSubState extends FlxSubState
{
    var box:FlxSprite;

    var portraitLeft:FlxSprite;
    var portraitRight:FlxSprite;

    var dialogue:Array<DialogueLine> = [];
    var diaTxt:FlxText;
    var curLine:Int = 0;

    var showingDialogue:Bool = false;

    public function new(dialogue:Array<DialogueLine> = [])
    {
        super();

        this.dialogue = dialogue;
        createDialogueBox();
        nextLine();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE && showingDialogue)
            nextLine();
        else if (FlxG.keys.justPressed.ENTER)
            closeDialogue();
    }

    function createDialogueBox()
    {
        box = new FlxSprite(20, FlxG.height - 120).makeGraphic(FlxG.width - 40, 100, FlxColor.BLACK);
        add(box);

        diaTxt = new FlxText(box.x + 10, box.y + 10, box.width - 20, "", 12);
        diaTxt.setFormat(Paths.font('vcr'), 12, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(dialogue);

        portraitLeft = new FlxSprite(30, box.y + 10);
        portraitLeft.scale.set(2, 2);
        add(portraitLeft);

        portraitRight = new FlxSprite(FlxG.width - 60, box.y + 10);
        portraitRight.scale.set(2, 2);
        add(portraitRight);
    }

    function nextLine()
    {
        if (curLine < dialogue.length)
        {
            var line:DialogueLine = dialogue[curLine];
            diaTxt.text = line.text;
            portraitLeft.loadGraphic(line.leftPortrait);
            portraitLeft.visible = line.leftPortrait != null;
            portraitRight.loadGraphic(line.rightPortrait);
            portraitRight.visible = line.rightPortrait != null;
            curLine++;
            showingDialogue = true;
        }
        else
            closeDialogue();
    }

    function closeDialogue()
    {
        curLine = 0;
        diaTxt.text = "";
        portraitLeft.visible = false;
        portraitRight.visible = false;
        this.kill();
    }
}

class DialogueLine
{
    public var text:String;
    public var leftPortrait:Class<FlxSprite>;
    public var rightPortrait:Class<FlxSprite>;

    public function new(text:String, leftPortrait:Class<FlxSprite> = null, rightPortrait:Class<FlxSprite> = null)
    {
        this.text = text;
        this.leftPortrait = leftPortrait;
        this.rightPortrait = rightPortrait;
    }
}