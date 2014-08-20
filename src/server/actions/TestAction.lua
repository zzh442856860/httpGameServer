
local TestAction = class("TestAction", cc.server.ActionBase)

function TestAction:indexAction( data )
	if not self.app.count then self.app.count = 0 end
	self.app.count = self.app.count + 1
	return {ret = string.format("SHOW ME THE MONEY [%s:%d]", data.say, self.app.count)}	
end

function TestAction:testAction( data )
	local redis = self.app:getRedis()
	local ret, err = redis:command("set", data.usr, data.pwd)
	ngx.say(ret, " ", err)
	return {id = data.id, usr = data.usr, pwd = data.pwd}
end

function TestAction:( ... )
	-- body
end

return TestAction
