--[[
	关卡1-2 【boss】
]]
local configs = {

	levelId = 1, --第1小关
	groupId = 1, --第1大关
	animName = "boss1", --图片名字
	skilltrigger = {   --技能触发
		moveLeftFire = {
			0.95, 0.80,
		},
		moveRightFire = {
			0.65, 0.30,
		},
		daoDan = {
			0.99,0.90,0.70, 0.60, 0.50, 0.40,
		},
		weak2 = {
			0.70,
		},	
		weak3 = {
			0.30,
		},							
	}
	
}



function getBoss(levelId, groupId)
	assert(configs)
	return configs
end

function getMoveLeftAction(scale)
	local move1 = cc.MoveBy:create(6/60, cc.p(0, 0))
	local move2 = cc.MoveBy:create(7/60, cc.p(-23, 0))
	local move3 = cc.MoveBy:create(7/60, cc.p(-33, 0))	
	local move4 = cc.MoveBy:create(9/60, cc.p(-32, 0))
	local move5 = cc.MoveBy:create(9/60, cc.p(-10, 0))
	return cc.Sequence:create(move1, move2, move3, move4, move5)
end
--  0帧：     0；0
--  6帧：     0；0
-- 13帧： -23；2
-- 20帧： -56；-5
-- 29帧： -88；-4
-- 40帧：-78；-4
function getMoveRightAction(scale)
	local move1 = cc.MoveBy:create(6/60, cc.p(0, 0))
	local move2 = cc.MoveBy:create(7/60, cc.p(23, 0))
	local move3 = cc.MoveBy:create(7/60, cc.p(33, 0))	
	local move4 = cc.MoveBy:create(9/60, cc.p(32, 0))
	local move5 = cc.MoveBy:create(9/60, cc.p(10, 0))
	return cc.Sequence:create(move1, move2, move3, move4, move5)
end

function getMoveLeftFireAction(scale)
	
end

function getMoveRightFireAction(scale)
	
end