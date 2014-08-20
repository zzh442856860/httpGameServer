--登陆系统

local LoginAction = class("LoginAction", cc.server.ActionBase)
--用户登陆
--@data:	--data.usr
			--data.pwd
			--data.server
			--data.ver
function LoginAction:loginAction( data )
	
end
--用户登出

function LoginAction:logoutAction( data )
	-- body
end
--验证版本，本地数据准确性等
function LoginAction:checkAction( data )
	-- body
end

return LoginAction
