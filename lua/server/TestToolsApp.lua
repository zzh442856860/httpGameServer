local TestToolsApp = class("TestToolsApp", cc.server.CommandLineServerBase)

function TestToolsApp:ctor( config, arg )
	-- body
	TestToolsApp.super.ctor(self, config)
	self.arg = arg
	self.config.actionPackage = "tools"
	self.config.actionModuleSuffix = "Tool"
end

function TestToolsApp:doRequest( actionName, data )
	-- body
	printf("> run tool %s\n", actionName)
	--so niubility style of writting!!!
	local ok, result = xpcall(function( )
		return TestToolsApp.super.doRequest(self, actionName, data)
	end, function( msg )
		return msg .. "\n" .. debug.traceback("", 4)
	end)
	if not ok then
		printf("> error: 5s\n", result)
	end
end

function TestToolsApp:runEventLoop( )
	local actionName = self.arg[1]
	if not acitionName then actionName = "help" end
	local arg = clone(self.arg)
	table.remove(arg, 1)
	return self:doRequest(actionName, arg)
end

return TestToolsApp
