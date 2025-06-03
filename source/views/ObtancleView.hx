package views;

import flixel.FlxG;
import components.PhysicsBodyComponent;
import components.ComponentContainer;
import flixel.FlxSprite;

class ObtancleView extends FlxSprite
{
	var componentContainer:ComponentContainer;
	var physicsBodyComponent:PhysicsBodyComponent;

	public function new(x:Float, y:Float, width:Int, height:Int)
	{
		super(x, y);
		componentContainer = new ComponentContainer();
		makeGraphic(width, height);
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (!isOnScreen() && _canDelete())
		{
			kill();
			destroy();
		}
	}

	function _canDelete()
	{
		var point = FlxG.camera.scroll;
		if (x <= point.x)
		{
			return true;
		}
		return false;
	}
}
