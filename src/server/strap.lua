
require("server.lib.init")
require("server.lib.errors")

local config = require("server.config")

local app = require("server.HttpServerApp").new(config)

app:run()
