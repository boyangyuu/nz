
local dir = "res/help/bangzhu/"
local postfix = ".ExportJson"
local config = {}

config["guangyu"]      = dir.."guangyu"..postfix
config["bangzhu"]      = dir.."bangzhu"..postfix

local AboutPopup = class("AboutPopup", function()
	return display.newLayer()
end)
function AboutPopup:ctor(param)
	-- body
	self.popupName = param.popupName
	self:initText()
	self:loadCCS()
	self:initButtons()
	
end

function AboutPopup:loadCCS()
	self.aboutNode = cc.uiloader:load(config[self.popupName])
	self.aboutNode:setScale(1.0)
	self:initContent()
	self:addChild(self.aboutNode)
end

function AboutPopup:initButtons()
	local closeBtn = cc.uiloader:seekNodeByName(self,"btnclose")
	closeBtn:setTouchEnabled(true)
	addBtnEventListener(closeBtn, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			if self.popupName == "bangzhu" then
				ui:closePopup("AboutPopup", {animName = "normal"})
			else
				ui:closePopup("AboutPopup")
			end
		end
	end)
end

function AboutPopup:initText()
	if self.popupName == "bangzhu" then
		local text = {
				-- "\n全民突袭 \n \n",
				"故事背景:\n",
				"    故事发生在2034年，主人公“杰”收到姐姐的留言，要",
				"他代替姐姐去执行一个艰巨的任务。然而等待他的是",
				"姐姐的遇难和上司的背叛。“杰”和他的队友身处极度",
				"危险之中，错综复杂的世界，他们将面对诸多敌人，",
				"随时随地准备对抗迎面而来的袭击。 ",
				"\n\n操作方法:",
				"\n瞄准:滑动屏幕移动准星。",
				"\n射击:点击右下角射击按钮开枪，长按可连续射击。",
				"\n手雷:瞄准敌人后，点击手雷按钮。",
				"\n盾牌:点击防爆盾牌图标，可抵挡敌人的攻击，使用盾",
				"牌时可以继续攻击。",
				"\n机甲变身:点击屏幕右上方的机甲按钮，驾驶机甲，可",
				"免受任何伤害。",
				"\n黄金变身:点击黄金变身按钮，对敌人造成巨大伤害。 ",		
				"\n功能界面:",
				"\n点击关卡图标:进入准备界面。",
				"\n武器库:购买各种武器，玩家可以选择2把武器带入战",
				"斗。",
				"\n武器升级:花费金币提高武器的属性。",
				"\n装备:为主角装备各种零件，额外提高战斗力量。",
				"战斗结束后零件消失。",
				"\n商城:花费购买各种道具。"										
				}
						
		self.text = "";
		for k,v in pairs(text) do
			self.text = self.text..v
		end
		print(self.text)
	end
end

function AboutPopup:initContent()
	if self.popupName == "bangzhu" then
		local textLabel = cc.uiloader:seekNodeByName(self.aboutNode, "context")
		print(self.text)
		textLabel:setString(self.text)
	end

	if self.popupName == "guangyu" then
		local versionLabel = cc.uiloader:seekNodeByName(self.aboutNode, "version")
		versionLabel:setString(__versionId)
		local gameName = cc.uiloader:seekNodeByName(self.aboutNode, "gameName")
		gameName:setString(__appName)
		local gameType = cc.uiloader:seekNodeByName(self.aboutNode, "gameType")
		gameType:setString("射击")
		local company = cc.uiloader:seekNodeByName(self.aboutNode, "company")
		company:setString("北京浩歌通途信息技术有限公司")
		local phone = cc.uiloader:seekNodeByName(self.aboutNode, "phone")
		phone:setString("010-82602182")
		local email = cc.uiloader:seekNodeByName(self.aboutNode, "email")
		email:setString("2758942941@qq.com")
		local qq = cc.uiloader:seekNodeByName(self.aboutNode, "qq")
		qq:setString("2758942941") 
	end
end



return AboutPopup