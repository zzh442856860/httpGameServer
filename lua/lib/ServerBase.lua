local ServerBase = class("ServerBase")

function ServerBase:ctor( config )
	-- body
	self.isRunning = true
	self.config = clone(totable(config))

end

function ServerBase:run(  )
	-- body
	self.isRunning = false
end

function ServerBase:getMysql( )
	-- body
	if not self.mysql then
		self.mysql = self:newMysql()
		return self.mysql
	end

	return self.mysql
end

return ServerBase