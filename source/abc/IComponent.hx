package abc;

interface IComponent
{
	public var active:Bool;
	public function update(elapsed:Float):Void;
	public function destroy():Void;
}
