
--where to find this socket.lua?
local ok, socket = pcall(function(  )
	return require("socket")
end)

if ok then 
	math.randomseed(socket.gettime() * 1000)
else
	math.randomseed(os.time())
end
--why 4 random???
math.random()
math.random()
math.random()
math.random()

if type(DEBUG) ~= "number" then DEBUG = 1 end
local CURRENT_MODULE_NAME = ...   --Need I change this ?? change it to a new module name??

-- init shared framework modules
cc = cc or {}
cc.PACKAGE_NAME = string.sub(CURRENT_MODULE_NAME, 1, -6)
cc.VERSION = "2.0.0"
cc.FRAMEWORK_NAME = "quick-cocos2d-x server"

require("framework.debug")
require("framework.functions")
json = require("cjson")

require(cc.PACKAGE_NAME .. ".functions")
require(cc.PACKAGE_NAME .. ".errors")

cc.server = {}
cc.server.ServerAppBase         = require(cc.PACKAGE_NAME .. ".ServerAppBase")

--init base classed

--init components

--init mvc

