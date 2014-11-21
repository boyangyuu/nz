--[[
	boss 1
]]

local BossConfig = class("BossConfig_1", cc.mvc.ModelBase)
local FightConfigs = import(".FightConfigs")
local configs = {

	levelId = 1, --第1小关
	groupId = 1, --第1大关
	animName = "boss1", --图片名字
	hp = 2000,
	demage = 50,
	fireRate = 200,
	walkRate = 200,
	fireOffset = 0.2,
	dmageScale = 2.1,
	
	skilltrigger = {   --技能触发(可以同时)
		moveLeftFire = {
			0.95, 0.70,
		},
		moveRightFire = {
			0.65, 0.30,
		},
		daoDan = {
			0.90, 0.60, 0.50, 0.40,
		},
		saoShe = {
			0.65, 0.55,
		},
		weak2 = {
			0.70,
		},	
		weak3 = {
			0.30,
		},							
	}
}


function getBoss(index)
	local wave = FightConfigs:getWaveConfig(levelId, groupId)
end

function getMoveLeftAction(scale)
	local move1 = cc.MoveBy:create(10/60, cc.p(0, 0))
	local move2 = cc.MoveBy:create(15/60, cc.p(-18, 0))
	local move3 = cc.MoveBy:create(13/60, cc.p(-45, 0))	
	local move4 = cc.MoveBy:create(7/60, cc.p(-12, 0))
	local move5 = cc.MoveBy:create(15/60, cc.p(-4, 0))
	return cc.Sequence:create(move1, move2, move3, move4, move5)
end

function getMoveRightAction(scale)
	local move1 = cc.MoveBy:create(10/60, cc.p(10, 0))
	local move2 = cc.MoveBy:create(15/60, cc.p(30, 0))
	local move3 = cc.MoveBy:create(10/60, cc.p(10, 0))	
	local move4 = cc.MoveBy:create(15/60, cc.p(12, 0))
	local move5 = cc.MoveBy:create(10/60, cc.p(4, 0))
	return cc.Sequence:create(move1, move2, move3, move4, move5)
end

function getMoveLeftFireAction(scale)
	
end

function getMoveRightFireAction(scale)
	
end