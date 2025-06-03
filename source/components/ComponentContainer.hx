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

	public function addComponent(component:IComponent, name:String):Void
	{
		components.set(name, component);
	}

	public function removeComponent(name:String):Void
	{
		components.remove(name);
	}

	public function getComponent(name:String):IComponent
	{
		return components.get(name);
	}

	public function update(elapsed:Float):Void
	{
		for (component in components)
		{
			component.update(elapsed);
		}
	}

	public function destroy():Void
	{
		for (component in components)
		{
			component.destroy();
		}
	}
}
