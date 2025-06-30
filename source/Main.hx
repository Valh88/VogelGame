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
import openfl.geom.Vector3D;
import away3d.primitives.LineSegment;
import away3d.entities.SegmentSet;

class Main extends Sprite
{
	var view3D:View3D;
	var sphere:Mesh;
	var chain:SegmentSet;
	var anchor:Vector3D;
	var chainLength:Int = 8;
	var chainSegments:Array<LineSegment>;
	var time:Float = 0;

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


		anchor = new Vector3D(0, -200, 0);


		sphere = new Mesh(new SphereGeometry(40, 40, 32), material);
		view3D.scene.addChild(sphere);

		// Цепь
		chain = new SegmentSet();
		chainSegments = [];
		for (i in 0...chainLength) {
			var seg = new LineSegment(anchor, anchor, 0x888888, 0x888888, 3);
			chain.addSegment(seg);
			chainSegments.push(seg);
		}
		view3D.scene.addChild(chain);

		// var flxGame = new FlxGame(0, 0, PlayState);
		// addChild(flxGame);

		this.addEventListener("enterFrame", function(_) {
			time += 0.02;
	
			var radius = 120.0;
			var angle = Math.sin(time) * 0.7; 
			var x = Math.sin(angle) * radius;
			var y = Math.cos(angle) * radius;
			var z = Math.cos(time) * 40;
			sphere.x = x;
			sphere.y = y;
			sphere.z = z;


			var prev = anchor;
			for (i in 0...chainLength) {
				var t = (i + 1) / chainLength;
				var cx = anchor.x + (sphere.x - anchor.x) * t;
				var cy = anchor.y + (sphere.y - anchor.y) * t;
				var cz = anchor.z + (sphere.z - anchor.z) * t;
				var next = new Vector3D(cx, cy, cz);
				chainSegments[i].start = prev;
				chainSegments[i].end = next;
				prev = next;
			}

			view3D.render();
		});
	}
}
