--邮件系统

local MailAction = class("MailAction", cc.server.ActionBase)

--刷新，获得最新的邮件，服务器会传下新的邮件，已经接受的邮件，客户端自己保存
function MailAction:flushAction( data )
	-- body
end

return MailAction

