package ui;

import flixel.math.FlxMath;
import flixel.group.FlxSpriteGroup;

using StringTools;

// Kind of based off of FNF

class Alphabet extends FlxSpriteGroup
{
    public var text:String = "";

    var finalText:String = "";
    var splitWords:Array<String> = [];

    var lastSprite:AlphaCharacter;
    var lastWasSpace:Bool = false;

    public var isMenuItem:Bool = false;
    public var targetY:Float = 0;

    public function new(x:Float, y:Float, text:String)
    {
        super(x, y);

        this.text = text;
        finalText = text;

        if (text != "")
            addText();
    }

    public function addText()
    {
        splitWords = finalText.split("");

        var xPos:Float = 0;
        var yPos:Float = 0;

        for (character in splitWords)
        {
            if (character == " ")
                lastWasSpace = true;

            if (character == "\n")
            {
                yPos += 5;
                xPos = 0;
                lastWasSpace = false;
                continue;
            }

            if (AlphaCharacter.alphabet.indexOf(character.toLowerCase()) != -1)
            {
                if (lastSprite != null)
                    xPos = lastSprite.x + lastSprite.width;

                if (lastWasSpace)
                {
                    xPos += 10;
                    lastWasSpace = false;
                }

                var letter:AlphaCharacter = new AlphaCharacter(xPos, 0);
                letter.createLetter(character);
                add(letter);

                lastSprite = letter;
            }
        }
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (isMenuItem)
        {
            var scaledY = FlxMath.remapToRange(targetY, 0, 1, 0, 1.3);

            y = FlxMath.lerp(y, (scaledY * 120) + (FlxG.height * 0.48), 0.16);
            x = FlxMath.lerp(x, (targetY * 20) + 90, 0.16);
        }
    }
}

class AlphaCharacter extends FlxSprite
{
    public static var alphabet:String = "abcdefghijklmnopqrstuvwxyz";

    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic(Paths.image('alphabet'), true, 16, 16);
    }

    public function createLetter(letter:String)
    {
        var frame:Int = 0;

        switch (letter)
        {
            case 'a':
                frame = 0;
            case 'b':
                frame = 1;
            case 'c':
                frame = 2;
            case 'd':
                frame = 3;
            case 'e':
                frame = 4;
            case 'f':
                frame = 5;
            case 'g':
                frame = 6;
            case 'h':
                frame = 7;
            case 'i':
                frame = 8;
            case 'j':
                frame = 9;
            case 'k':
                frame = 10;
            case 'l':
                frame = 11;
            case 'm':
                frame = 12;
            case 'n':
                frame = 13;
            case 'o': // CASEOH???
                frame = 14;
            case 'p':
                frame = 15;
            case 'q':
                frame = 16;
            case 'r':
                frame = 17;
            case 's':
                frame = 18;
            case 't':
                frame = 19;
            case 'u':
                frame = 20;
            case 'v':
                frame = 21;
            case 'w':
                frame = 22;
            case 'x':
                frame = 23;
            case 'y':
                frame = 24;
            case 'z':
                frame = 25;
            default:
                // nothing idk
        }
        animation.add(letter, [frame], 1);
        animation.play(letter);
    }
}