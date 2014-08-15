
local HttpServerApp = class("HttpServerApp", cc.server.HttpServerBase)

function HttpServerApp:ctor( config )
	--
	HttpServerApp.super.ctor(self, config)
end

function HttpServerApp:doRequest( actionName, data )
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

return HttpServerApp
