--注册系统

local RegAction = class("RegAction", cc.server.ActionBase)
--用户注册
--@data:	--data.usr
			--data.pwd	:	pwd+salt 进行md5运算
			--data.server:	服务器id
			--data.phone:	手机号
			--data.ver
function RegAction:regAction( data )
	
end
--获取服务器列表
function RegAction:getLAction( data )
	-- body
end
--注册服务器--服务器启动后，会到这里注册自己
--@data:	--data.ip
			--data.port
			--data.name
function RegAction:regSAction( data )
	-- body
end

return RegAction
