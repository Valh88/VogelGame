package views;

import components.AnimationPlayer;
import components.CbTypes;
import flixel.addons.nape.FlxNapeSpace;
import nape.dynamics.InteractionFilter;
import nape.shape.Polygon;
import nape.phys.BodyType;
import nape.phys.Body;
import components.PhysicsBodyComponent;
import flixel.util.FlxColor;
import components.Movement;
import components.ComponentContainer;
import flixel.FlxSprite;

class PlayerView extends FlxSprite
{
	public var speed:Float;

	public var componentContainer:ComponentContainer;

	var _movement:Movement;
	var _physicsBodyComponent:PhysicsBodyComponent;
	var _animation:AnimationPlayer;
	public function new(x:Float, y:Float)
	{
		super(x, y);
		width = 16.0;
		height = 16.0;
		speed = 200;
		loadGraphic(AssetPaths.fogel_anim_3__png, true, 110, 101);
		
		#if (desktop || web)
		scale.set(0.7, 0.7);
		#else
		scale.set(2, 2);
		#end 
		
		_animation = new AnimationPlayer(this.animation);
		
		componentContainer = new ComponentContainer();

		var physicsBody = new Body(BodyType.DYNAMIC);
		var shape = new Polygon(Polygon.rect(0, 0, width, height));

		var playerFilter = new InteractionFilter();
		playerFilter.collisionGroup = 2;
		shape.filter = playerFilter;

		physicsBody.shapes.add(shape);
		physicsBody.space = FlxNapeSpace.space;
		physicsBody.cbTypes.add(CbTypes.PLAYER_CBTYPE);
		physicsBody.userData.playerView = this;
		_physicsBodyComponent = new PhysicsBodyComponent(x, y, width, height, physicsBody);

		_movement = new Movement(speed, _animation);
		_movement.physicsComponent = _physicsBodyComponent;

		componentContainer.addComponent(_physicsBodyComponent, "physicsBody");
		componentContainer.addComponent(_movement, "movement");
		componentContainer.addComponent(_animation, "animation");

		// _animation.fly();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		componentContainer.update(elapsed);
		_updateCoordinates();
	}

	function _updateCoordinates()
	{
		x = _physicsBodyComponent.physicsBody.position.x;
		y = _physicsBodyComponent.physicsBody.position.y;
	}

	override public function destroy():Void
	{
		componentContainer.destroy();
	}
}
