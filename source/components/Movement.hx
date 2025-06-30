package components;

import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import abc.IComponent;
import flixel.FlxG;
import flixel.FlxSprite;

class Movement implements IComponent
{
	public var speed:Float;
	public var force:Float;
	public var active:Bool;
	public var velocity:FlxPoint = new FlxPoint();
	public var physicsComponent:PhysicsBodyComponent;
	public var timer:FlxTimer;
	public var animation:AnimationPlayer;
	public var sprite:FlxSprite;

	var _canForce:Bool;
	var _isFlying:Bool = false;
	var _targetAngle:Float = 0;
	var _rotationSpeed:Float = 5.0; 
	
	public function new(active = true, speed:Float, animation:AnimationPlayer, sprite:FlxSprite)
	{
		this.active = active;
		this.speed = 200;
		this.force = 1000;
		this._canForce = true;
		this.timer = new FlxTimer();
		this.animation = animation;
		this.sprite = sprite;
		this._targetAngle = 0;
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
				_isFlying = true;
				animation.fly();
				
				_targetAngle = -20;
				
				timer.start(0.1, function(timer:FlxTimer)
				{
					velocity.y = speed;
					_canForce = true;
					_isFlying = false;
					_targetAngle = 0;
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
					_isFlying = true;
					animation.fly();
					
					_targetAngle = -20;
					
					timer.start(0.1, function(timer:FlxTimer)
					{
						velocity.y = speed * 4;
						_canForce = true;
						_isFlying = false;
						_targetAngle = 0;
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
		
		if (!_isFlying && velocity.y > 0) {
			_targetAngle = 20;
		} else if (!_isFlying && velocity.y <= 0) {
			_targetAngle = 0;
		}
		
		_updateRotation(elapsed);
		
		physicsComponent.velocity = velocity;
	}
	
	function _updateRotation(elapsed:Float):Void
	{
		var angleDiff = _targetAngle - sprite.angle;
		
		if (angleDiff > 180) angleDiff -= 360;
		if (angleDiff < -180) angleDiff += 360;
		
		var rotationStep = _rotationSpeed * elapsed * 60; 
		
		if (Math.abs(angleDiff) > rotationStep) {
			if (angleDiff > 0) {
				sprite.angle += rotationStep;
			} else {
				sprite.angle -= rotationStep;
			}
		} else {
			sprite.angle = _targetAngle;
		}
	}

	public function destroy():Void
	{
	}
}
