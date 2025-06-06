package components;

import flixel.animation.FlxAnimationController;
import flixel.FlxSprite;
import abc.IComponent;

class AnimationPlayer implements IComponent 
{
    public var active:Bool;
    public var animation:FlxAnimationController;

    public function new(?active = true, animation:FlxAnimationController)  
    {
        this.active = active;
        this.animation = animation;
        animation.add("fly", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 10, true);
        animation.add("pary", [3], true);
    }

    public function fly() 
    {
		animation.play("fly");    
    }

    public function pary() 
    {
        animation.play("pary");    
    }

    public function update(elapsed:Float)
    {
        
    }

    public function destroy() 
    {
        
    }
}