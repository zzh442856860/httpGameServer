local TestWorkerApp = class("TestWorkerApp", cc.server.CommandLineServerBase)

function TestWorkerApp:ctor( config )
	TestWorkerApp.super.ctor(self, config)
	self.config.workerMaxRequestCount = config.workerMaxRequestCount or 100
	self.config.actionPackage = "workers"
	self.config.actionModuleSuffix = "Worker"
	self.requestCount = 0
end

function TestWorkerApp:doRequest( actionName, data )
	return pcall(function( )
		return TestWorkerApp.super.doRequest(self, actionName, data)
	end, function(msg )
		return msg
	end)
end

function TestWorkerApp:runEventLoop(  )
	--
	--bean
	while true do 
		self.requestCount = self.requestCount + 1

		if self.requestCount > self.config.workerMaxRequestCount then
			echoInfo("Worker %s over max requests, shutdown", tostring(self))
			break
		end

		--bean
		
	end
end

function TestWorkerApp:parseJobMessage( rawMessage )
	if self.config.workerMessageFormat == "json" then
		local message = json.decode(rawMessage)
		if type(message) == "table" then
			return true, message 
		else
			return false, string.format("invalid message, %s", tostring(rawMessage))
		end
	else
		return false, string.format("not support message format %s", tostring(self.config.workerMessageFormat))
	end
end

return TestWorkerApp
