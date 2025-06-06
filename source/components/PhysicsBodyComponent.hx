package components;

import nape.dynamics.InteractionFilter;
import nape.geom.Vec2;
import flixel.math.FlxPoint;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.phys.BodyType;
import nape.phys.Body;
import flixel.addons.nape.FlxNapeSpace;
import abc.IComponent;

class PhysicsBodyComponent implements IComponent
{
	public var active:Bool;
	public var physicsBody:Body;
	public var width:Float;
	public var height:Float;
	public var velocity:FlxPoint;

	public function new(active:Bool = true, x:Float, y:Float, width:Float, height:Float, body:Body)
	{
		this.active = active;
		this.width = width;
		this.height = height;
		this.velocity = new FlxPoint();
		this.physicsBody = body;
		physicsBody.position.setxy(x + width, y + height);
	}

	public function addVorce(?velocityDiff:Vec2)
	{
		if (velocityDiff != null)
		{
			var force = velocityDiff.mul(physicsBody.mass * 5.0);
			physicsBody.force = force;
		} else
		{
			var velocityDiff = new Vec2(velocity.x - physicsBody.velocity.x, velocity.y - physicsBody.velocity.y);
			var force = velocityDiff.mul(physicsBody.mass * 5.0);
			physicsBody.force = force;
		}
	}

	public function update(elapsed:Float)
	{
		addVorce();
	}

	public function destroy()
	{
		if (physicsBody.space != null)
		{
			physicsBody.space = null;
		}
	}
}
