local FightConfigs = class("FightConfigs", cc.mvc.ModelBase)


function FightConfigs:getWaveConfig(group, level)
	local p = "app.fight.FightConfigs"
	local name_lua = "wave"..group.."_"..level
	local str_src = "."..name_lua
	local waveFight = require(p .. str_src)
	dump(waveFight, "waveFight")
	return waveFight
end

function FightConfigs:getFocusRange()
	return 20
end

return FightConfigs