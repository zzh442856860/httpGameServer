--签到系统

local QianAction = class("QianAction", cc.server.ActionBase)

--进入签到界面，显示所有装备以及领取情况，如果本地有记录，不予服务器通信
function QianAction:flushAction( data )
	-- body
end

--点击某图标，如果已领，不予服务器通信。如果本地没保存，请求服务器
function QianAction:getAction( data )
	-- body
end

return QianAction
