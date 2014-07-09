local cjson = require "cjson"

local request_method = ngx.var.request_method
local args = nil
local data = nil
local param = {}
local cmd = nil

ngx.say(os.time())

--redis test 
local redis = require "resty.redis"
local red = redis:new()
red:set_timeout(1000)

local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
	ngx.say("failed to connect: ", err)
	return
end

ok, err = red:set("dog", "an animal")
if not ok then
	ngx.say("failed to set dog: ", err)
	return
end

ngx.say("set result: ", ok)
