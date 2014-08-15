local Component = class("Component")
--
--@name:
--@depends: what mean?
function Component:ctor( name, depends )
	-- body
	self.name_ = name 
	self.depends_ = totable(depends)
end

function Component:getName(  )
	-- body
	return self.name_
end

function Component:getDepends(  )
	-- body
	return self.depends_
end

function Component:getTarget(  )
	-- body
	return self.target_
end

function Component:exportMethods_( methods )
	-- body
	self.exportMethods_ = methods
	local target = self.target_
	local name = self.name_
	local com = self
	--这里写的极其复杂, i don't understand
	for _, key in ipairs(methods) do
		if not target[key] then
			target[key] = function( __, ... )
				-- body
				local r = {com[key](self, ...)}
				if r[1] == self then r[1] = target end
				return unpack(r)
			end
		end
	end

	return self
end

function Component:bind_( target )
	-- body
	self.target_ = target
	--depends哪里设置的
	for _, name in ipairs(self.depends_) do 
		if not target:checkComponent(name) then
			target:addComponent(name)
		end
	end
	self:onBind_(target)
end

function Component:unbind_(  )
	-- body
	if self.exportMethods_ then
		local target = self.target_
		for _, key in ipairs(self.exportMethods_) do
			target[key] = nil
		end
	end
	self:onUnbind_()
end
--未实现，等待别人来继承，再实现？
function Component:onBind_(  )
	-- body
end

function Component:onUnbind_(  )
	-- body
end

return Component

