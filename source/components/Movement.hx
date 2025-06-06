package components;

import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import abc.IComponent;
import flixel.FlxG;

class Movement implements IComponent
{
	public var speed:Float;
	public var force:Float;
	public var active:Bool;
	public var velocity:FlxPoint = new FlxPoint();
	public var physicsComponent:PhysicsBodyComponent;
	public var timer:FlxTimer;
	public var animation:AnimationPlayer;

	var _canForce:Bool;
	public function new(active = true, speed:Float, animation:AnimationPlayer)
	{
		this.active = active;
		this.speed = 200;
		this.force = 1000;
		this._canForce = true;
		this.timer = new FlxTimer();
		this.animation = animation;
	}

	#if (desktop || web)
	public function clickButtonMovement():Void
	{
		if(_canForce)
		{
			if (FlxG.keys.anyJustPressed([UP, W, SPACE]))
			{	
				velocity.y += -force * 2;
				_canForce = false;
				animation.fly();
				timer.start(0.1, function(timer:FlxTimer)
				{
					velocity.y = speed;
					_canForce = true;
				});
			}
		}
	}
	#end

	#if mobile
	public function tocheButtonMovement() 
	{
		for (touch in FlxG.touches.list) {
			if(_canForce)
			{
				if (touch.justPressed) 
				{
					velocity.y += -force * 4;
					_canForce = false;
					animation.fly();
					timer.start(0.1, function(timer:FlxTimer)
					{
						velocity.y = speed * 4;
						_canForce = true;
					});
					
				}
			}
			
			if (touch.pressed) {
				var centerX = FlxG.width / 2;
				var centerY = FlxG.height / 2;
				
				var moveX = (touch.x - centerX) / centerX;
				var moveY = (touch.y - centerY) / centerY;
				
				moveX = Math.max(-1, Math.min(1, moveX));
				moveY = Math.max(-1, Math.min(1, moveY));
			}
			
			if (touch.justReleased) {
				// trace("\nTouch ended: " + touch.x + ", " + touch.y +  ")");
			}
		}

		// trace("\nTotal touches: " + FlxG.touches.list.length);
		
	}
	#end
	
	public function update(elapsed:Float):Void
	{
		#if (desktop || web)
		velocity.x = speed;
		clickButtonMovement();
		#end
		#if mobile
		velocity.x = speed * 2;
		tocheButtonMovement();
		#end
		physicsComponent.velocity = velocity;
	}

	public function destroy():Void
	{
	}
}
