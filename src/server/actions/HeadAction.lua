--头像系统

local HeadAction = class("HeadAction", cc.server.ActionBase)

--进入头像界面，刷新所有要现实的属性，如果本地有，不予服务器通信
function HeadAction:flushAction( data )
	-- body
end

--更改昵称
function HeadAction:nameAction( data )
	-- body
end

--更改头像
function HeadAction:headAction( data )
	-- body
end

--更改头像框
function HeadAction:headKAction( data )
	-- body
end

--退出公会
function HeadAction:exitSAction( data )
	-- body
end

return HeadAction


