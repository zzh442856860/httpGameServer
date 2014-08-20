
local ServerAppBase = import(".ServerAppBase")
local HttpServerBase = class("HttpServerBase", ServerAppBase)

function HttpServerBase:ctor( config )
	--ngx.say("HttpServerBase:ctor")
	HttpServerBase.super.ctor(self, config)
	self.config.requestType = "http"

	self.requestMethod = ngx.req.get_method()
	self.requestParameters = ngx.req.get_uri_args()
	--echoInfo(ngx.req.get_uri_args())
	if self.requestMethod == "POST" then
		ngx.req.read_body()
		table.merge(self.requestParameters, ngx.req.get_post_args())
	end

	if self.config.session then
		self.session = cc.server.Session.new(self)
	end

end

--
function HttpServerBase:process()
	ngx.say("HttpServerBase:process")
	local args = self.requestParameters
	ngx.say(type(args))
	if args ~= nil then
		if type(args) == "table" then
			--ngx.say(self.config.httpMessageFormat)
			local par = args[self.config.httpMessageFormat]
			if par ~= nil then
				self:processMessage(par)
			end
		end
	end
	-- if type(args) == "table" then
	-- 	ngx.say("args is table")
	-- 	ngx.say(args["json"])
	-- else
	-- 	ngx.say("args is not table")
	-- end

	-- for key, val in pairs(args) do
	-- 	if type(val) == "table" then
	-- 		ngx.say(key, ": ", table.concat(val, ", "))
	-- 	else
	-- 		ngx.say(key, ": ", val)
	-- 	end
	-- end

	--echoInfo(tostring(args))
	-- if args ~= nil then
	-- 	self:processMessage(args["json"])
	-- 	--self.super:processMessage(args)
	-- end
end

return HttpServerBase
