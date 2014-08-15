--???how to use??

local HelpTool = class("HelpTool", cc.server.ActionBase)

function HelpTool:indexAction(  )
	-- body
	print([[
usage: tools <action> [arg] [arg]

example:
	* show this help 
	tools help 

	* create map
	tools map.create

		]])
end

return HelpTool

