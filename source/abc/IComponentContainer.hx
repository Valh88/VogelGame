package abc;

import abc.IComponent;

interface IComponentContainer
{
	public function addComponent<T:IComponent>(component:T, name:String):T;
	public function removeComponent(name:String):Void;
	public function getComponent<T:IComponent>(name:String, type:Class<T>):T;
	public function hasComponent(name:String):Bool;
	public function update(elapsed:Float):Void;
	public function destroy():Void;
}
