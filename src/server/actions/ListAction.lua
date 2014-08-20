--排行榜系统

local ListAction = class("ListAction", cc.server.ActionBase)

--竞技场排行榜
function ListAction:arenaAction( data )
	-- body
end

--公会活跃排行榜
function ListAction:socAction( data )
	-- body
end

--藏宝地穴掠夺榜
function ListAction:robAction( data )
	-- body
end

--藏宝地穴开采榜
function ListAction:mineAction( data )
	-- body
end

return ListAction
