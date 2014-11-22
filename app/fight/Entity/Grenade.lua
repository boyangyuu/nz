local Grenade = class("Grenade")

function Grenade.createGrenade(srcPos, destPos, arriveCallBack, isEnemy)
	local destScale = 3
	local srcScale = 0.3
	if isEnemy then
		destScale = 2.5
		srcScale = 0.5
	end

	local tGrenade = getArmature("shoulei", "res/Fight/heroAnim/shoulei/shoulei.ExportJson")
	tGrenade:setPosition(srcPos)
	tGrenade:setScale(srcScale)
	tGrenade:getAnimation():play("lei", -1, 1)
	tGrenade:runAction(
		cc.Sequence:create(
			cc.Spawn:create(cc.JumpTo:create(1, destPos, 200, 1), cc.ScaleTo:create(1, destScale)),
		 	cc.CallFunc:create(
		 		function ()
	                -- self.hero:dispatchEvent({name = Hero.SKILL_GRENADE_ARRIVE_EVENT, damage = 600, destPos = event.throwPos})
	                arriveCallBack()
					tGrenade:removeFromParent()
				end
			)
		)
	)
	return tGrenade
end

return Grenade