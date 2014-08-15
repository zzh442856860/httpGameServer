--游戏对象，主要就是封装了对组件库的操作
local Registry = import(".Registry")

local GameObject = {}

function GameObject.extend( target )
	-- body
	target.components_= {}

	function target:checkComponent( name )
		-- body
		return self.components_[name] ~= nil
	end

	function target:addComponent( name )
		-- body
		local component = Registry.newObject(name)
		self.components_[name] = component
		component:bind_(self) --绑定的是这个object，而不是target
		return component
	end

	function target:removeComponent( name )
		-- body
		local component = self.components_[name]
		if component then component:unbind_() end 
		self.components_[name] = nil 
	end

	function target:getComponent( name )
		-- body
		return self.components_[name]
	end

	return target
end

return GameObject