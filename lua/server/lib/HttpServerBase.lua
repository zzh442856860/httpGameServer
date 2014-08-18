
local ServerAppBase = import(".ServerAppBase")
local HttpServerBase = class("HttpServerBase", ServerAppBase)

function HttpServerBase:ctor( config )
	-- body
	HttpServerBase.super.ctor(self, config)
	self.config.requestType = "http"

	self.requestMethod = ngx.req.get_method()
	self.requestParameters = ngx.req.get_uri_args()
	if self.requestMethod == "POST" then
		ngx.req.read_body()
		table.merge(self.requestParameters, ngx.req.get_post_args())
	end

	local ok, err = ngx.on_abort(function()
		self:dispatchEvent({name = ServerAppBase.CLIENT_ABORT_EVENT})
	end)
	if not ok then
		echoInfo("failed to register the on_abort callback, ", err)
	end

	if self.config.session then
		self.session = cc.server.Session.new(self)
	end

end

function HttpServerBase:runEventLoop(  )
	-- body
end

function HttpServerBase:processMessage( rawMessage )
	local ok, message = self:parseMessage(rawMessage)
	if not ok then
		return false, message 
	end

	local msgid = message._id_
	local actionName = message.action 
	local result = self:doRequest(actionName, message)

	
end

function HttpServerBase:parseMessage( rawMessage )
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

return HttpServerBase