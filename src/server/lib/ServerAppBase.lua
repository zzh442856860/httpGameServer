
local ServerAppBase = class("ServerAppBase")

function ServerAppBase:ctor( config )
	--ngx.say("ServerAppBase:ctor")
	self.isRunning = true
	self.config = clone(totable(config))
	self.config.appModuleName = config.appModuleName or "server"
	self.config.actionPackage = config.actionPackage or "actions"
	self.config.actionModuleSuffix = config.actionModuleSuffix or "Action"
end

function ServerAppBase:run( )
	ngx.say("ServerAppBase:run")
	self:process()
	self.isRunning =false
end

function ServerAppBase:process( )
	ngx.say("---ServerAppBase:process")
	throw(ERR_SERVER_OPERATION_FAILED, "ServerAppBase:process() - must override in inherited class")
end

function ServerAppBase:doRequest( actionName, data )
	ngx.say("---ServerAppBase:doRequest")
	local actionModuleName, actionMethodName = self:normalizeActionName(actionName)
	--ngx.say(actionModuleName, " ", actionMethodName)
	actionModuleName = string.format("%s.%s%s", self.config.actionPackage, string.ucfirst(actionModuleName), self.config.actionModuleSuffix)
    actionMethodName = actionMethodName .. "Action"
    --ngx.say(actionModuleName, " ", actionMethodName)

    local actionModule = self:require(actionModuleName)
    local t = type(actionModule)
    if t ~= "table" and t ~= "userdata" then
        throw(ERR_SERVER_INVALID_ACTION, "failed to load action module %s", actionModuleName)
    end

    local action = actionModule.new(self)
    local method = action[actionMethodName]
    if type(method) ~= "function" then
        throw(ERR_SERVER_INVALID_ACTION, "invalid action %s:%s", actionModuleName, actionMethodName)
    end

    if not data then
        data = self.requestParameters or {}
    end
    return method(action, data)
end

function ServerAppBase:newService( name )
	return self:require(string.format("services.%sService", string.ucfirst(name))).new(self)
end

function ServerAppBase:require( moduleName )
	moduleName = self.config.appModuleName .. "." .. moduleName
	return require(moduleName)
end

function ServerAppBase:normalizeActionName( actionName )
	--where to find GET methods???
	local actionName = actionName or (self.GET.action or "index.index")
	actionName = string.gsub(actionName, "[^%a.]", "")  --regex ,I don't understand
	actionName = string.gsub(actionName, "^[.]+", "")
    actionName = string.gsub(actionName, "[.]+$", "")

	local parts = string.split(actionName, ".")
	if #parts == 1 then parts[2] = 'index' end 
	return parts[1], parts[2]
end

function ServerAppBase:newReids( config )
	local redis = cc.server.RedisEasy.new(config or self.config.redis)
	local ok, err = redis:connect()
	if not ok then
		throw(ERR_SERVER_OPERATION_FAILED, "failed to connect redis, %s", err)
	end
	return redis 
end

function ServerAppBase:getRedis(  )
	if not self.redis then
		self.redis = self:newReids()
	end
	return self.redis 
end

function ServerAppBase:processMessage( rawMessage )
	ngx.say("ServerAppBase:processMessage")

	local ok, message = self:parseMessage(rawMessage)
	if not ok then
		ngx.say("not ok ", message)
		return false, message 
	end 

	local msgid = message.id 
	local actionName = message.action 
	ngx.say(message.id, " ", message.action)
	local result = self:doRequest(actionName, message)

	if result then
		ngx.say(json.encode(result))
	end 

	return true
end

function ServerAppBase:parseMessage( rawMessage )
	ngx.say("ServerAppBase:parseMessage")
	--ngx.say(rawMessage)
	if self.config.httpMessageFormat == "json" then
		local message = json.decode(rawMessage)
		if type(message) == "table" then
			return true, message
		else 
			return false, string.format("invalid message format %s", tostring(rawMessage))
		end 
	else
		return false, string.format("not support message format %s", tostring(self.config.httpMessageFormat))
	end 
end

return ServerAppBase

