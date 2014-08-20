-- 任务系统

local TaskAction = class("TaskAction", cc.server.ActionBase)

--进入任务界面，刷新，显示未完成的任务。如果本地有，直接读本地
function TaskAction:flushAction( data )
	-- body
end

return TaskAction
