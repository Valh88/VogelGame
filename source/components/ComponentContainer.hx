package components;

import abc.IComponentContainer;
import abc.IComponent;

class ComponentContainer implements IComponentContainer
{
	public var components:Map<String, IComponent>;

	public function new()
	{
		components = new Map<String, IComponent>();
	}

	public function addComponent<T:IComponent>(component:T, name:String):T
	{
		components.set(name, component);
		return component;
	}

	public function removeComponent(name:String):Void
	{
		components.remove(name);
	}

	public function getComponent<T:IComponent>(name:String, type:Class<T>):T
	{
		var component = components.get(name);
		if (component != null && Std.isOfType(component, type)) {
			return cast component;
		}
		return null;
	}

	public function hasComponent(name:String):Bool
	{
		return components.exists(name);
	}

	public function update(elapsed:Float):Void
	{
		for (component in components)
		{
			if (component.active) {
				component.update(elapsed);
			}
		}
	}

	public function destroy():Void
	{
		for (component in components)
		{
			component.destroy();
		}
		components.clear();
	}
}
