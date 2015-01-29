

local StoryLayer = class("StoryLayer", function()
	return display.newLayer()
end)

function StoryLayer:ctor(properties)
	self.properties = properties
	self.talks = {}
	self:loadCCS()
	self:setTalks()
	self:initButton()
end

function StoryLayer:loadCCS()
	local filePath = "res/storyBackground/storybackground.ExportJson"
	self.storyNode = cc.uiloader:load(filePath)
	self:addChild(self.storyNode)
end

function StoryLayer:setTalks()
	local posSet = {1136, -1111 ,1136}
	local fileName = "talk"
	for i = 1,3 do
		local talk = cc.uiloader:seekNodeByName(self.storyNode, fileName..i)
		talk:setPosition(posSet[1], 121)
		self.talks[fileName..i] = talk
	end
	
	-- for i = 1, 3 do
		self.talks[fileName..1]:moveTo(0.5,28,121)
		self:speak(self.talks[fileName..1])
	-- end

end

function StoryLayer:initButton()
	local btnContinue = cc.uiloader:seekNodeByName(self.storyNode, "continue")
	btnContinue:setVisible(false)
end

function StoryLayer:speak(talk)
	local label1 = cc.uiloader:seekNodeByName(talk ,"Label_1")
	label1:speak(0.1)

	local str = "    不知道老哥又搞什么飞机,什么也不说就让我来这里,还穿的这么稀奇古怪,看来今天的假期就这么报废了"
	local label2 = cc.uiloader:seekNodeByName(talk, "Label_2")
	label2:setString(str)
	-- label2:speak(0.1)

end

return StoryLayer