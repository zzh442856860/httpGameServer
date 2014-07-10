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

local mysql = require "resty.mysql"
local db, err = mysql:new()
if not db then
	ngx.say("failed to instantiate mysql: ", err)
	return
end

db:set_timeout(1000)

local ok, err, errno, sqlstate = db:connect{
	host = "127.0.0.1",
	port = 3306,
	database = "ngx_test",
	user = "root",
	password = "zhangzhonghua",
	max_packet_size = 1024 * 1024
}

if not ok then
	ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
	return
end

ngx.say("connected to mysql.")
