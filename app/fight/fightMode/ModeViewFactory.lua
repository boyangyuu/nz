local ModeViewFactory = class("ModeViewFactory",cc.mvc.ModelBase)

local FightModeXianshiView = import(".FightModeXianshiView")
local FightModePutongView  = import(".FightModePutongView")
local FightModeRenzhiView  = import(".FightModeRenzhiView")
local FightModeTaofanView  = import(".FightModeTaofanView")
local FightModeBossContestView  = import(".FightModeBossContestView")

function ModeViewFactory.getModeView()
	local fightMode  = md:getInstance("FightMode")
	local modeConfig = fightMode:getModeConfig()

	local view
	local type = modeConfig.type	
	if type == "xianShi" then 
		view = FightModeXianshiView.new()
	elseif type == "renZhi" then
		view = FightModeRenzhiView.new()
	elseif type == "taoFan" then
		view = FightModeTaofanView.new()
	elseif type == "puTong" then
		view = FightModePutongView.new()	
	elseif type == "bossContest" then
		view = FightModeBossContestView.new()			
	else
		assert(false, "invalid type ；"..type)
	end
	return view
end

return ModeViewFactory