--附魔系统

local FumoAction = class("FumoAction", cc.server.ActionBase)

--点击附魔按钮
function FumoAction:fumoAction( data )
	-- body
end
--获取所有人物装备情况,本地登录的，直接读取本地记录，不是本地的，需要从服务器获取一份
function FumoAction:getLAction( data )
	-- body
end

return FumoAction
