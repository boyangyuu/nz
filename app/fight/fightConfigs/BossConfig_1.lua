--[[
	boss 1
]]


local BossConfig = class("BossConfig_1", cc.mvc.ModelBase)
local FightConfigs = import(".FightConfigs")

function BossConfig:getMoveLeftAction(scale)
	local move1 = cc.MoveBy:create(10/60, cc.p(0, 0))
	local move2 = cc.MoveBy:create(15/60, cc.p(-18, 0))
	local move3 = cc.MoveBy:create(13/60, cc.p(-45, 0))	
	local move4 = cc.MoveBy:create(7/60, cc.p(-12, 0))
	local move5 = cc.MoveBy:create(15/60, cc.p(-4, 0))
	return cc.Sequence:create(move1, move2, move3, move4, move5)
end

function BossConfig:getMoveRightAction(scale)
	local move1 = cc.MoveBy:create(10/60, cc.p(10, 0))
	local move2 = cc.MoveBy:create(15/60, cc.p(30, 0))
	local move3 = cc.MoveBy:create(10/60, cc.p(10, 0))	
	local move4 = cc.MoveBy:create(15/60, cc.p(12, 0))
	local move5 = cc.MoveBy:create(10/60, cc.p(4, 0))
	return cc.Sequence:create(move1, move2, move3, move4, move5)
end

function BossConfig:getMoveLeftFireAction(scale)
	
end

function BossConfig:getMoveRightFireAction(scale)
	
end

return BossConfig