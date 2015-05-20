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
	{{money = 100}}, --第一关奖励
	{{money = 200}},--2
	{{money = 300}},--3
	{{money = 400}},--4
	{{money = 500}},--5
	{{money = 600}},--6
	{{healthBag = 2},{lei = 5},{money = 700}},--7坎boss
	{{healthBag = 1},{lei = 2},{money = 800}},--8
	{{healthBag = 1},{lei = 2},{money = 900}},--9
	{{healthBag = 1},{lei = 2},{money = 1000}},--10
	{{healthBag = 1},{lei = 2},{money = 1100}},--11坎加难度
	{{healthBag = 1},{lei = 2},{money = 1200}},--12
	{{healthBag = 1},{lei = 2},{money = 1300}},--13
	{{healthBag = 3},{lei = 5},{money = 1400}},--14坎boss
	{{healthBag = 1},{lei = 3},{money = 1500}},--15坎
	{{healthBag = 1},{lei = 3},{money = 1600}},--16
	{{healthBag = 1},{lei = 3},{money = 1700}},--17
	{{healthBag = 1},{lei = 3},{money = 1800}},--18
	{{healthBag = 1},{lei = 3},{money = 1900}},--19
	{{healthBag = 1},{lei = 3},{money = 2000}},--20
	{{healthBag = 3},{lei = 5},{money = 2100}},--21坎boss
	{{healthBag = 1},{lei = 3},{money = 2200}},--22
	{{healthBag = 1},{lei = 3},{money = 2300}},--23
	{{healthBag = 1},{lei = 3},{money = 2400}},--24
	{{healthBag = 1},{lei = 3},{money = 2500}},--25坎
	{{healthBag = 1},{lei = 3},{money = 2600}},--26
	{{healthBag = 1},{lei = 3},{money = 2700}},--27
	{{healthBag = 3},{lei = 5},{money = 2800}},--28坎boss
	{{healthBag = 1},{lei = 3},{money = 2900}},--29
	{{healthBag = 1},{lei = 3},{money = 3000}},--30
	{{healthBag = 1},{lei = 3},{money = 3100}},--31
	{{healthBag = 1},{lei = 3},{money = 3200}},--32
	{{healthBag = 1},{lei = 3},{money = 3300}},--33
	{{healthBag = 1},{lei = 3},{money = 3500}},--34
	{{healthBag = 1},{lei = 3},{money = 3600}},--35
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