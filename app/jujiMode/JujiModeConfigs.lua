local JujiModeConfigs = class("JujiModeConfigs", cc.mvc.ModelBase)

local JujiConfigs = {}

scoreAward = {
	{score = 10000, diamond = 500},
	{score = 8000, diamond = 200},
	{score = 6000, diamond = 50},
	{score = 4000, money = 300000},
	{score = 2000, money = 150000},
	{score = 1000, money = 50000},
}

fightAward = {
	{{healthBag = 2},{lei = 3},{money = 65199}}, --第一关奖励
	{{healthBag = 2},{lei = 3},{money = 65199}},--2
	{{healthBag = 2},{lei = 3},{money = 65199}},--3
	{{healthBag = 2},{lei = 3},{money = 65199}},--4
	{{healthBag = 2},{lei = 3},{money = 65199}},--5
	{{healthBag = 2},{lei = 3},{money = 65199}},--6
	{{healthBag = 2},{lei = 3},{money = 65199}},--7
	{{healthBag = 2},{lei = 3},{money = 65199}},--8
	{{healthBag = 2},{lei = 3},{money = 65199}},--9
	{{healthBag = 2},{lei = 3},{money = 65199}},--10
	{{healthBag = 2},{lei = 3},{money = 65199}},--11
	{{healthBag = 2},{lei = 3},{money = 65199}},--12
	{{healthBag = 2},{lei = 3},{money = 65199}},--13
	{{healthBag = 2},{lei = 3},{money = 65199}},--14
	{{healthBag = 2},{lei = 3},{money = 65199}},--15
	{{healthBag = 2},{lei = 3},{money = 65199}},--16
	{{healthBag = 2},{lei = 3},{money = 65199}},--17
	{{healthBag = 2},{lei = 3},{money = 65199}},--18
	{{healthBag = 2},{lei = 3},{money = 65199}},--19
	{{healthBag = 2},{lei = 3},{money = 65199}},--20
	{{healthBag = 2},{lei = 3},{money = 65199}},--21
	{{healthBag = 2},{lei = 3},{money = 65199}},--22
	{{healthBag = 2},{lei = 3},{money = 65199}},--23
	{{healthBag = 2},{lei = 3},{money = 65199}},--24
	{{healthBag = 2},{lei = 3},{money = 65199}},--25
	{{healthBag = 2},{lei = 3},{money = 65199}},--26
	{{healthBag = 2},{lei = 3},{money = 65199}},--27
	{{healthBag = 2},{lei = 3},{money = 65199}},--28
	{{healthBag = 2},{lei = 3},{money = 65199}},--29
	{{healthBag = 2},{lei = 3},{money = 65199}},--30
	{{healthBag = 2},{lei = 3},{money = 65199}},--31
	{{healthBag = 2},{lei = 3},{money = 65199}},--32
	{{healthBag = 2},{lei = 3},{money = 65199}},--33
	{{healthBag = 2},{lei = 3},{money = 65199}},--34
	{{healthBag = 2},{lei = 3},{money = 65199}},--35
}

function JujiModeConfigs.getFightAward(levelIndex)
	assert(levelIndex, "关卡id is nil")
	local rewardConfig = fightAward[levelIndex]
	return rewardConfig
end

function JujiModeConfigs.getScoreAward(awardIndex)
	assert(awardIndex, "awardIndex is nil")
	local rewardConfig = scoreAward[awardIndex]
	return rewardConfig
end

return JujiModeConfigs