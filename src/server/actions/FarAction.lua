--远征系统

local FarAction = class("FarAction", cc.server.ActionBase)

--进入远征界面，获取用户具体闯了多少关，剩余次数等信息
function FarAction:flushAction( data )
	-- body
end

--点击关卡，获取当前关卡详细信息，例如守关敌人，奖励物品等
function FarAction:getAction( data )
	-- body
end

function FarAction:beforeFAction( data )
	-- body
end

function FarAction:afterFAction( data )
	-- body
end

return FarAction
