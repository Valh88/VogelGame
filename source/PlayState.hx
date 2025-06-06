package;

import flixel.math.FlxRect;
import views.ObtancleView;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.addons.nape.FlxNapeSpace;
import views.PlayerView;
import flixel.util.FlxColor;
import flixel.FlxState;

class PlayState extends FlxState
{
	var _mainPlayer:PlayerView;
	var _currentXScreen:Int;
	var _scrollBountScreenHeight:Float;

	override public function create()
	{
		super.create();
		FlxNapeSpace.init();
		FlxNapeSpace.space.gravity.setxy(0, 600);

		bgColor = FlxColor.ORANGE;
		_currentXScreen = FlxG.width;

		_mainPlayer = new PlayerView(100, 100);

		_scrollBountScreenHeight = FlxG.height + FlxG.height * 0.2;

		FlxG.camera.setScrollBounds(null, null, 0, _scrollBountScreenHeight);
		FlxG.worldBounds.set(-10000, 0, 10000, _scrollBountScreenHeight);
		FlxG.camera.follow(_mainPlayer, FlxCameraFollowStyle.LOCKON, 0.1);
		createObtangle(FlxG.width - FlxG.width / 2, 0, Std.int(FlxG.width * 0.15), Std.int(_scrollBountScreenHeight * 0.35));
		createObtangle(FlxG.width - FlxG.width / 2, FlxG.height - FlxG.height * 0.35, Std.int(FlxG.width * 0.15), Std.int(_scrollBountScreenHeight * 0.5));

		add(_mainPlayer);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		_generateObtanglesInWorld();
	}

	public function createObtangle(x:Float, y:Float, width:Int, height:Int)
	{
		var obtancle = new ObtancleView(x, y, width, height);
		add(obtancle);
	}

	function _generateRandom(min:Float, max:Float)
	{
		return min + (max - min) * Math.random();
	}

	function _generateObtanglesInWorld() 
	{
		if (_checkForObtangle())
		{
			var coficient = _generateRandom(0.2, 0.6);
			var two = 1 - coficient - 0.2;
			createObtangle(_currentXScreen + 400, 0, Std.int(FlxG.width * 0.15), Std.int(_scrollBountScreenHeight * coficient));

			createObtangle(_currentXScreen + 400, _scrollBountScreenHeight - _scrollBountScreenHeight * two, Std.int(FlxG.width * 0.15),
				Std.int(_scrollBountScreenHeight * 0.8));

			#if (desktop || web)
			_currentXScreen += Std.int(FlxG.width / 2);
			#else
			_currentXScreen += Std.int(FlxG.width) - 400;
			#end
		}
	}

	function _checkForObtangle()
	{
		if (_mainPlayer.x >= _currentXScreen)
		{
			return true;
		}
		return false;
	}
}
