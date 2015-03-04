
local StoryLayer = class("StoryLayer", function()
	return display.newLayer()
end)

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

function StoryLayer:onEnter()
	--test
	ui:changeLayer("FightPlayer", {groupId = 0, 
		levelId = 0})	
	--testend
end

function StoryLayer:loadCCS()
	local filePath = "res/storybord/storybord.ExportJson"
	self.storyNode = cc.uiloader:load(filePath)
	self:addChild(self.storyNode)
end


function StoryLayer:initTalks()
	local posSet = {-250, 1232 ,-250}
	local fileName = "talk"
	for i = 1,3 do
		local talk = cc.uiloader:seekNodeByName(self.storyNode, fileName..i)
		if i ~= 1 then
			talk:setVisible(false)
		end
		self.talks[fileName..i] = talk
		local purson = cc.uiloader:seekNodeByName(talk, "purson"..i)
		purson:setPosition(posSet[i], 240)
		self.pursons["purson"..i] = purson

	end
	
	self:changeTalk()
end

function StoryLayer:initTouchEvent()
	self.btnContinue = cc.uiloader:seekNodeByName(self.storyNode, "btncontinue")
	self.btnContinue:setVisible(false)
	-- self.btnContinue:setTouchEnabled(true)
	self:setTouchEnabled(false)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self.btnContinue:setVisible(false)
			if self.id < 3 then
				self:setTouchEnabled(false)
				self.talks["talk"..self.id]:setVisible(false)
				self.id = self.id + 1
				self:changeTalk()
			else

				local data = getUserData()
				data.guide.gamePre = true
				setUserData(data)
				ui:changeLayer("FightPlayer", {groupId = 0, 
					levelId = 0})				
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
	table.insert(self.actions, cc.CallFunc:create(function()
		self.btnContinue:setVisible(true)
		self:setTouchEnabled(true)
	end))
	self:runAction(transition.sequence(self.actions))

end

return StoryLayer