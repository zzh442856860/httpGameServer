--采矿系统（藏宝地穴）

local MineAction = class("MineAction", cc.server.ActionBase)

--进入采矿界面，获取并显示矿物开采情况
function MineAction:flushAction( data )
	-- body
end

--探寻宝藏
function MineAction:searchAction( data )
	-- body
end

--
function MineAction:afterFAction( data )
	-- body
end

--防守记录按钮
function MineAction:defAction( data )
	-- body
end

--点击视频回放按钮
function MineAction:videoAction( data )
	-- body
end

return MineAction
