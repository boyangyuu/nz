
local StoryLayer = class("StoryLayer", function()
	return display.newLayer()
end)

local speakActionTag = 10000

local configs = {
	talk1 = {
		Label2 = "不知道安琪儿又搞什么飞机，什么也",
		Label3 = "不说就让我来这里，我的战队还等我一起",
		Label4 = "刷图呢！看来暑假就这么报废了！！！"
	},
	talk2 = {
		Label2 = "你师姐深陷敌人腹地！被他们俘获",
		Label3 = "了！！现在只有你可以控制战神机甲，",
		Label4 = "你已经破格被龙组录用了，代号“杰”。"
 	},
 	talk3 = {
 		Label2 = "啊！我师姐那么漂亮，岂不很危险！？",
 		Label3 = "让开，快把机甲给我！我要去救她！！",
 		Label4 = ""
 	}
}

function StoryLayer:ctor(properties)
	self.properties = properties
	self.talks = {}
	self.pursons = {}
	self.id = 1
	self:loadCCS()
	self:initTalks()
	self:initTouchEvent()
	self:setNodeEventEnabled(true)
end

function StoryLayer:loadCCS()
	local filePath = "res/storybord/storybord.ExportJson"
	self.storyNode = cc.uiloader:load(filePath)
	self:addChild(self.storyNode)
end

function StoryLayer:onEnter()
	--um
    local guide = md:getInstance("Guide")
    guide:checkGuideUM("preStory")
end

function StoryLayer:initTalks()
	local posSet = {-250, 1232 ,-250}
	local fileName = "talk"
	for i = 1,3 do
		local talk = cc.uiloader:seekNodeByName(self.storyNode, fileName..i)
		self:initTalkWords(talk, fileName..i)
		if i ~= 1 then
			talk:setVisible(false)
		end
		self.talks[fileName..i] = talk
		local purson = cc.uiloader:seekNodeByName(talk, "purson"..i)
		purson:setScale(1.43)
		purson:setPosition(posSet[i], 240)
		self.pursons["purson"..i] = purson
	end
	
	self:changeTalk()
end

function StoryLayer:initTalkWords(talk, talkName)
	local name = "Label"
	for i = 2,4 do
		local label = cc.uiloader:seekNodeByName(talk, name..i)
		if label then
			label:setString(configs[talkName][name..i])
		end
	end
end

function StoryLayer:initTouchEvent()
	local touchLayer = display.newLayer()
	touchLayer:setContentSize(cc.size(1136, 640))
	self:addChild(touchLayer)
	touchLayer:setTouchEnabled(true)
	touchLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			if not self:isShowNext() then return end
			self.talks["talk"..self.id]:setVisible(false)
			self.id = self.id + 1
			if self.id <= 3 then
				self:changeTalk()
			else
				local fightData = {
					groupId = 0, 
					levelId = 0,
				}				
				ui:changeLayer("FightPlayer", {fightData = fightData})				
			end
		end
	end)
end

-- 人物交替出现
function StoryLayer:changeTalk()
	self:stopAllActions()
	self.actions = nil
	self.actions = {cc.DelayTime:create(0.3)}
	print("StoryLayer:changeTalk():",self.id)
	-- if self.id < 4 then
		self.talks["talk"..self.id]:setVisible(true)
		if self.id ~= 2 then
			self.pursons["purson"..self.id]:moveTo(0.2,214,240)
		else
			self.pursons["purson"..self.id]:moveTo(0.2,860,240)
		end
		self:speak(self.talks["talk"..self.id])
	-- end
end

-- 文字打印
function StoryLayer:speak(talk)
	local name = "Label"
	local talkName = "talk"..self.id
	for i = 2,4 do
		local label = cc.uiloader:seekNodeByName(talk, name..i)
		if label then
			table.insert(self.actions, cc.CallFunc:create(function()
				print("antion : ",i)	
				label:setVisible(true)
				label:speak(0.05)
			end))
			table.insert(self.actions, cc.DelayTime:create(1))
		end
	end
	local actionSequence = transition.sequence(self.actions)
	actionSequence:setTag(speakActionTag)
	self:runAction(actionSequence)
end

function StoryLayer:isShowNext()

	--判断是否在执行speak动作
	local action = self:getActionByTag(speakActionTag)
	if (action and action:isDone()) or action == nil then
		return true
	end

	--让当前talk的所有speak显示出来
	self:stopAllActions()
	local talkName = "talk"..self.id
	local talk = self.talks[talkName]
	local name = "Label"
	for i = 2,4 do
		local label = cc.uiloader:seekNodeByName(talk, name..i)
		if label then
			if label:isSpeaking() then
				label:stopSpeak()
			end
			label:setVisible(true)
		end
	end
	return false
end

return StoryLayer