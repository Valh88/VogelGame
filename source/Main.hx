package;

import openfl.display.Sprite;
import flixel.FlxGame;
import away3d.containers.View3D;
import away3d.primitives.SphereGeometry;
import away3d.entities.Mesh;
import away3d.materials.ColorMaterial;
import away3d.lights.PointLight;
import away3d.materials.lightpickers.StaticLightPicker;
import away3d.materials.methods.FogMethod;
import away3d.materials.TextureMaterial;
import away3d.materials.methods.BasicDiffuseMethod;
import away3d.materials.methods.BasicSpecularMethod;
import away3d.textures.BitmapTexture;
import openfl.Assets;

class Main extends Sprite
{
	var view3D:View3D;

	public function new()
	{
		super();

		view3D = new View3D();
		addChild(view3D);


		var light = new PointLight();
		light.x = 300;
		light.y = 300;
		light.z = -700;
		view3D.scene.addChild(light);

		var lightPicker = new StaticLightPicker([light]);

		var material = new ColorMaterial(0xFF0000);
		material.lightPicker = lightPicker;
		material.specular = 1;
		material.gloss = 50;

		var sphere = new Mesh(new SphereGeometry(100, 40, 32), material); 
		view3D.scene.addChild(sphere);


		// var flxGame = new FlxGame(0, 0, PlayState);
		// addChild(flxGame);


		this.addEventListener("enterFrame", function(_) {
			sphere.rotationY += 1;
			view3D.render();
		});
	}
}
