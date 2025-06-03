package abc;

import abc.IComponent;

interface IComponentContainer
{
	public var components:Map<String, IComponent>;

	public function addComponent(component:IComponent, name:String):Void;
	public function removeComponent(name:String):Void;
	public function getComponent(name:String):IComponent;
	// public function hasComponent(name:String):Bool;
	// public function getComponents():Array<IComponent>;
	// public function getComponentsByType(type:Class<IComponent>):Array<IComponent>;
	public function update(elapsed:Float):Void;
	public function destroy():Void;
}
