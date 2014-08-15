local Component = import("..Component")
local EventProtocol = class("EventProtocol", Component)

function EventProtocol:ctor(  )
	-- body
	--???"EventProtocol" is depends??? a string type???
	--Component:ctor( name, depends )
	--???"EventProtocol" is name ,, not depends
	EventProtocol.super.ctor(self, "EventProtocol")
	--here, init all members, it's very clear!
	self.listeners_ = {}
	self.listenerHandleIndex_ = 0
	self.debug_ = false
end
--@eventName
--@listener
--@data: ???
function EventProtocol:addEventListener( eventName, listener, data )
	-- body
	eventName = string.upper(eventName)
	if self.listeners_[eventName] == nil then
		self.listeners_[eventName] = {}
	end

	self.listenerHandleIndex_ = self.listenerHandleIndex_ + 1
	--why use a string key, not number directly
	local handle = tostring(self.listenerHandleIndex_)
	--listener should be a function, but what type data is ?
	self.listeners_[eventName][handle] = {listener, data}

	if self.debug_ then
		if data then
			echoInfo("EventProtocol:addEventListener() - add listener [%s] %s:%s for event %s", handle, tostring(data), tostring(listener), eventName)
		else 
			echoInfo("EventProtocol:addEventListener() - add listener [%s] %s for event %s", handle, tostring(listener), eventName)
		end 
	end 

	return handle 
end
--dispatch event to a target ???
function EventProtocol:dispatchEvent( event )
	-- body
	event.name = string.upper(event.name)
	local eventName = event.name 
	if self.debug_ then
		echoInfo("EventProtocol:dispatchEvent() - dispatching event %s", eventName)
	end 

	if self.listeners_[eventName] == nil then return end 
	event.target = self.target_ --Compontent base class's member

	for handle, listener in pairs(self.listeners_[eventName]) do
		if self.debug_ then
			echoInfo("EventProtocol:dispatchEvent() - dispatching event %s to listener [%s]", eventName, handle)
		end
		local ret 
		--what is listener[2]? listener[2] is data!
		if listener[2] then
			--listener(data, event), ret is a function
			ret = listener[1](listener[2], event)
		else 
			--when data is nil, listener(event)
			ret = listener[1](event)
		end 

		if ret == false then
			if self.debug_ then
				echoInfo("EventProtocol:dispatchEvent() - break dispatching for event %s", eventName)
			end 
			break
		end 
	end 

	return self
end
--???
--1: key1 = handle, key2 = nil
--2: key1 = listener, key2 = data
function EventProtocol:removeEventListener( eventName, key1, key2 )
	-- body
	eventName = string.upper(eventName)
	if self.listeners_[eventName] == nil then return end 

	for handle, listener in pairs(self.listeners_[eventName]) do 
		if key1 == handle or (key1 == listener[1] and key2 == listener[2]) then
			self.listeners_[eventName][handle] = nil
			if self.debug_ then
				echoInfo("EventProtocol:removeEventListener() - remove listener [%s] for event %s", handle, eventName)
			end
			return handle
		end 
	end 

	return self 
end

function EventProtocol:removeAllEventListenersForEvent( eventName )
	-- body
	self.listeners_[string.upper(eventName)] = nil
	if self.debug_ then
		echoInfo("EventProtocol:removeAllEventListenersForEvent() - remove all listeners for event %s", eventName)
	end
	return self
end

function EventProtocol:removeAllEventListeners(  )
	-- body
	self.listeners_ = {}
	if self.debug_ then
		echoInfo("EventProtocol:removeAllEventListeners() - remove all listeners")
	end 
	return self
end
--打印出所有event，listeners
function EventProtocol:dumpAllEventListeners(  )
	-- body
	print("---- EventProtocol:dumpAllEventListeners() ----")
	for name, listeners in pairs(self.listeners_) do
		printf("-- event: %s", name)
		for handle, listener in pairs(listeners) do
			printf("--     handle: %s, %s", tostring(handle), tostring(listener))
		end 
	end 

	return self --why all funcs return self??? I think it should return nothing
end

function EventProtocol:setEventProtocolDebugEnabled( enabled )
	-- body
	self.debug_ = enabled
	return self  --why return? should return nothind
end

function EventProtocol:exportmethods(  )
	-- body
	--来自Component的成员变量
	self:exportmethods_({
		"addEventListener",
		"dispatchEvent",
		"removeEventListener",
		"removeAllEventListenersForEvent",
		"removeAllEventListeners",
	})
	return self
end
--这个继承来的方法还没有实现
function EventProtocol:onBind_(  )
	-- body
end

function EventProtocol:onUnbind_(  )
	-- body
end

return EventProtocol

