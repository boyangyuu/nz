
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
	sortType = sortType == "jujiLevel" and "level" or "vipLevel"

	self.rankData = self.rankConfig

    local loginTime = 1430067661
    local now = os.time()	
    local offsetTime = now - loginTime
    local offsetDays = math.floor(offsetTime / (24 * 60 * 60))
    if offsetDays > 7 then offsetDays = 7 end  	
    print("offsetDays", offsetDays)

    --grow
    for i,record in ipairs(self.rankData) do
    	local speed = record["growSpeed"]
    	record["level"] = math.floor(record["level"] + 
    			offsetDays * speed)
    end

	--add self
	self.rankData[#self.rankData + 1] = self:getUserRankData("jujiLevel")

    --sort
	local function sortFunction(record1, record2)
		local level1 = record1[sortType]
		local level2 = record2[sortType]
		return level1 > level2
	end
	table.sort(self.rankData, sortFunction)
	return self.rankData
end

function RankModel:getUserRankData(type)
	local userData = getUserData()
	local jujiLevel = userData.user.jujiRankLevel 

	local data = {}
	if type == "jujiMode" then 
		data = {
			name = self.user:getUserName(),
			level = jujiLevel,
		}
	elseif type == "boss" then	

	else
		assert(false)
	end

	return data
end

return RankModel