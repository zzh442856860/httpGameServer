--英雄系统

local HeroAction = class("HeroAction", cc.server.ActionBase)

--进入英雄界面执行的操作，获取所有英雄列表，包括装备技能等等，如果本地有，显示本地，不读服务器
function HeroAction:flushAction( data )
	-- body
end

--进阶按钮
function HeroAction:jieAction( data )
	-- body
end

--进化按钮
function HeroAction:evoAction( data )
	-- body
end

return HeroAction
