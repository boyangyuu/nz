
local RankModel = class("RankModel", cc.mvc.ModelBase)

function RankModel:ctor(properties)
	RankModel.super.ctor(self, properties)

	--instance
	self.user = md:getInstance("UserModel")
	self.rankData = {}
	self.rankConfig = {}

	self:initConfigTable()
end

function RankModel:initConfigTable()
	self.rankConfig = getConfig("config/jiqiren.json")
end

function RankModel:getRankData(sortType)
	--type 
	self.rankData = clone(self.rankConfig)
	local now = os.time()
    local registTime = self.user:getRegisterTime()
    if registTime == nil then 
    	print("registTime is nil")
    	registTime = now
    end
    local offsetTime = now - registTime
    local offsetDays = math.floor(offsetTime / (24 * 60 * 60))
    if offsetDays > 7 then offsetDays = 7 end  	
    print("offsetDays", offsetDays)

    --grow
    for i,record in ipairs(self.rankData) do
    	local speed = record["jujiSpeed"]
    	record[sortType] = math.floor(record[sortType] + 
    			offsetDays * speed)
    end

	--add self
	local userData = self:getUserRankData(sortType)
	self.rankData[#self.rankData + 1] = userData

	--add enemy
	local offset = math.random(0,3)
	local enemy = self:getUserRankData(sortType)
    enemy["name"] = "楼下的，请用力！"
    enemy["jujiLevel"] = userData["jujiLevel"] + offset
    self.rankData[#self.rankData + 1] = enemy

    --sort
	local function sortFunction(record1, record2)
		local level1 = record1[sortType]
		local level2 = record2[sortType]
		return level1 > level2
	end
	table.sort(self.rankData, sortFunction)
	return self.rankData
end

function RankModel:getUserRank()
	for i,v in ipairs(self.rankData) do
		if v.name == self.user:getUserName() and v.isUser == true then
			if 100 < i then 
				i = 499 * (i - 100) + 100	 
				return i
			else
				return i
			end
		end
	end
end

function RankModel:getUserRankData(type)
	local jujiModeModel = md:getInstance("JujiModeModel")
	local jujiLevel = jujiModeModel:getCurWaveIndex()

	local data = {}
	if type == "jujiLevel" then 
		data = {
			name = self.user:getUserName(),
			jujiLevel = jujiLevel,
			isUser = true,
		}
	elseif type == "boss" then	

	else
		assert(false)
	end

	return data
end

return RankModel