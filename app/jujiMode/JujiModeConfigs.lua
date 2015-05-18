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
	{{money = 500}}, --第一关奖励
	{{lei = 2},{money = 500}},--2
	{{lei = 2},{money = 1000}},--3
	{{lei = 2},{money = 1000}},--4
	{{lei = 2},{money = 1500}},--5
	{{lei = 2},{money = 1500}},--6
	{{healthBag = 2},{lei = 5},{money = 5000}},--7坎boss
	{{lei = 3},{money = 2000}},--8
	{{lei = 3},{money = 2000}},--9
	{{lei = 3},{money = 2000}},--10
	{{lei = 3},{money = 2000}},--11坎
	{{lei = 3},{money = 2000}},--12
	{{lei = 3},{money = 2000}},--13
	{{healthBag = 3},{lei = 5},{money = 5000}},--14坎boss
	{{healthBag = 2},{lei = 3},{money = 2000}},--15坎
	{{healthBag = 2},{lei = 3},{money = 2000}},--16
	{{healthBag = 2},{lei = 3},{money = 2000}},--17
	{{healthBag = 2},{lei = 3},{money = 2000}},--18
	{{healthBag = 2},{lei = 3},{money = 2000}},--19
	{{healthBag = 2},{lei = 3},{money = 2000}},--20
	{{healthBag = 2},{lei = 3},{money = 5000}},--21坎boss
	{{healthBag = 2},{lei = 3},{money = 2000}},--22
	{{healthBag = 2},{lei = 3},{money = 2000}},--23
	{{healthBag = 2},{lei = 3},{money = 2000}},--24
	{{healthBag = 2},{lei = 3},{money = 2000}},--25坎
	{{healthBag = 2},{lei = 3},{money = 2000}},--26
	{{healthBag = 2},{lei = 3},{money = 2000}},--27
	{{healthBag = 2},{lei = 3},{money = 5000}},--28坎boss
	{{healthBag = 2},{lei = 3},{money = 2000}},--29
	{{healthBag = 2},{lei = 3},{money = 2000}},--30
	{{healthBag = 2},{lei = 3},{money = 2000}},--31
	{{healthBag = 2},{lei = 3},{money = 2000}},--32
	{{healthBag = 2},{lei = 3},{money = 2000}},--33
	{{healthBag = 2},{lei = 3},{money = 2000}},--34
	{{healthBag = 2},{lei = 3},{money = 2000}},--35
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