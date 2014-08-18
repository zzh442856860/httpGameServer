
local TestsAction = class("TestsAction", cc.server.ActionBase)

function TestsAction:indexAction( data )
	if not self.app.count then self.app.count = 0 end
	self.app.count = self.app.count + 1
	return {ret = string.format("SHOW ME THE MONEY [%s:%d]", data.say, self.app.count)}	
end

return TestsAction
