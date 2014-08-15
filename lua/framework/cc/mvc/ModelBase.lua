
local ModelBase = class "ModelBase"
ModelBase.idkey = "id"
--存放属性的键的类型,etc
ModelBase.schema = {
	id = {"string"}
}
--存放属性的键
ModelBase.fields = {"id"}

--移除properties里的filter table's value
--@properties:
--@filter: a table 
local function filterProperties( properties, filter )
	-- body
	for i, field in ipairs(filter) do
		properties[field] = nil
	end
end
--create a modelBase class
function ModelBase:ctor( properties )
	-- body
	cc.GameObject.extend(self)--这句话就是让self增加了一堆操作component的方法
	self:addComponent("components.behavior.EventProtocol"):exportMethods() --这个方法哪里继承来的

	self:isModelBase_ = true
	if type(properties) ~= "table" then properties = {} end 
	self:setProperties(properties)
end
--只看到获取id，这个id到底哪里设置的,目前只有id这一个键
function ModelBase:getId( )
	-- body
	local id = self[self.class.idkey .. "_"]
	assert(id ~= nil, string.format("%s [%s:getId()] Invalid id", tostring(self), self.class.__cname))
	return id 
end
--这里只判断id这一个键
function ModelBase:isValidId(  )
	-- body
	local propname = self.class.idkey .. "_"
	local id = self[propname]
	return type(id) == "string" and id ~= ""
end
--设置属性，属性[id] = sth，这里的属性目前应该只有一个id键
function ModelBase:setProperties( properties )
	-- body
	assert(type(properties) == "table", "Invalid properties")

	for field, schema in pairs(self.class.schema) do
		local typ, def = unpack(schema) --typ is a string val; def should be a nil val
		local propname = field .. "_" --目前的propname只有一个id_

		local val = properties[field] or def
		if val ~= nil then
			if typ == "number" then val = tonumber(val) end 
			assert(type(val) == typ,
				string.format("%s [%s;setProperties()] Type mismath, %s expected %s, actual is %s",
					tostring(self), self.class.__cname, field, typ, type(val)))
			self[propname] = val 
		end
	end

	return self 
end

function ModelBase:getProperties( fields, filter )
	-- body
	local schema = self.class.schema
	if type(fields) ~= "table" then fields = self.class.fields end 

	local properties = {}
	for i, field in ipairs(fields) do 
		local propname = field .. "_"
		local typ = schema[field][1]
		local val = self[propname] --setProperties时，存起来的
		assert(type(val) == typ, 
			string.format("%s:getProperties() - Type mismath, %s expected %s, actual is %s",
				self.class.__cname, field, typ, type(val)))
		properties[field] = val 
	end 

	if type(filter) == "table" then
		filterProperties(properties, filter)
	end 

	return properties
end

return ModelBase 


