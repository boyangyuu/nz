local MidAutumnConfigs = class("MidAutumnConfigs", cc.mvc.ModelBase)

local fightAward = {}

fightAward = {
    {{moonCake = 10},{money = 2000}},
}


function MidAutumnConfigs.getConfig(levelIndex)
    if levelIndex == nil then levelIndex = 1 end
    local rewardConfig = fightAward[levelIndex]
    return rewardConfig
end

function MidAutumnConfigs.getConfigs()
    return fightAward
end

return MidAutumnConfigs