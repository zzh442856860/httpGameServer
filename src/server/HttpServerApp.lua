
local HttpServerApp = class("HttpServerApp", cc.server.HttpServerBase)

function HttpServerApp:ctor( config )
	--echoInfo("HttpServerApp:ctor\n")
	--
	--ngx.say("HttpServerApp:ctor")
	HttpServerApp.super.ctor(self, config)
end

function HttpServerApp:doRequest( actionName, data )
	--echoInfo("HttpServerApp:doRequest: ", actionName, data)
	--
	local function go(  )
		return HttpServerApp.super.doRequest(self, actionName, data)
	end

	if self.config.debug then
		local ok, result = pcall(function()
			return go() 
		end)
		if not ok then
			return self:onRequestError(actionName, result)
		end
		return result
	else
		return go()
	end
end

function HttpServerApp:onRequestError( actionName, result )
	echoInfo("onRequestError actionName: %s , result: %s", (self.requestParameters.action or "nil"), result)
end

-- function HttpServerApp:process( )
-- 	ngx.say("HttpServerApp:process")
-- 	ngx.say(self.xx)
-- 	ngx.say(type(self.requestParameters))
-- 	HttpServerApp.super.process(self)
-- end

return HttpServerApp
