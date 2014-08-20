--充值系统

local PayAction = class("PayAction", cc.server.ActionBase)

--进入界面，获取显示vip等级等信息，如果本地已经有了，不予服务器通信
function PayAction:flushAction( data )
	-- body
end

return PayAction
