package components;

import flixel.math.FlxPoint;
import abc.IComponent;
import flixel.FlxG;

class Movement implements IComponent
{
	public var speed:Float;
	public var active:Bool;
	public var velocity:FlxPoint = new FlxPoint();
	public var physicsComponent:PhysicsBodyComponent;

	public function new(active = true, speed:Float)
	{
		this.active = active;
		this.speed = 150;
	}

	public function clickButtonMovement():Void
	{
		if (FlxG.keys.anyPressed([LEFT, A]))
			velocity.x += -speed;
		if (FlxG.keys.anyPressed([D, RIGHT]))
			velocity.x += speed;
		if (FlxG.keys.anyPressed([UP, W]))
			velocity.y += -speed;
		if (FlxG.keys.anyPressed([DOWN, S]))
			velocity.y += speed;

		if (FlxG.keys.anyJustReleased([LEFT, A]))
			velocity.x -= -speed;
		if (FlxG.keys.anyJustReleased([D, RIGHT]))
			velocity.x -= speed;
		if (FlxG.keys.anyJustReleased([UP, W]))
			velocity.y -= -speed;
		if (FlxG.keys.anyJustReleased([DOWN, S]))
			velocity.y -= speed;

		if (!FlxG.keys.anyPressed([LEFT, A, D, RIGHT, UP, W, DOWN, S]))
		{
			velocity.y = 200;
		}
	}

	public function update(elapsed:Float):Void
	{
		velocity.x = speed;

		if(velocity.y >= 400 || velocity.y <= -400) 
		{
			velocity.y = 0;
		}

		clickButtonMovement();
		physicsComponent.velocity = velocity;
	}

	public function destroy():Void
	{
	}
}
