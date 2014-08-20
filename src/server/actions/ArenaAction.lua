--竞技场系统

local ArenaAction = class("ArenaAction", cc.server.ActionBase)
--刷新
function ArenaAction:flushAction( data )
	-- body
end

--跃进
function ArenaAction:leapAction( data )
	-- body
end
--进入战斗前， 获取敌方详细数据
function ArenaAction:beforeFAction( data )
	-- body
end
--战斗结束，传送战斗结果给服务器
function ArenaAction:afterFAction( data )
	-- body
end
--排行榜
function ArenaAction:getLAction( data )
	-- body
end
--更新防守阵容
function ArenaAction:updateAction( data )
	-- body
end
--获取对战记录
function ArenaAction:recordAction( data )
	-- body
end

return ArenaAction
