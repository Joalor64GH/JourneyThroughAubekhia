package ui;

class MenuButton extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);

        loadGraphic(Paths.image('buttons'), true, 16, 16);

        animation.add("playU", [0]); // unselected
        animation.add("playS", [1]); // selected
        animation.add("playP", [2]); // pressed

        animation.add("optionsU", [3]); 
        animation.add("optionsS", [4]); 
        animation.add("optionsP", [5]); 

        animation.add("retryU", [6]); 
        animation.add("retryS", [7]); 
        animation.add("retryP", [8]); 

        animation.add("menuU", [9]); 
        animation.add("menuS", [10]); 
        animation.add("menuP", [11]); 

        animation.add("quitU", [12]); 
        animation.add("quitS", [13]); 
        animation.add("quitP", [14]);

        scale.set(12, 12); 
    }
}