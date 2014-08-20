--每日活动系统

local ActAction = class("ActAction", cc.server.ActionBase)

--进入每日活动界面，刷新，显示所有任务完成情况
function ActAction:flushAction( data )
	-- body
end

--领取体力
function ActAction:vitAction( data )
	-- body
end

--买月卡
function ActAction:buyAction( data )
	-- body
end

--点金手
function ActAction:midasAction( data )
	-- body
end

return ActAction
