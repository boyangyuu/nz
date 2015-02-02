
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
			ui:closePopup("AboutPopup")
		end
	end)
end

function AboutPopup:initText()
	if self.popupName == "bangzhu" then
		local text = {
						"\n穿越火线之cs逆战射击 \n \n",
						"故事背景:\n",
						"      故事发生在2034年，主人公“杰”收到哥哥的留言，要\n",
						"他代替哥哥去执行一个艰巨的任务。然而等待他的是\n",
						"哥哥的遇难和上司的背叛。“杰”和他的队友身处极度\n",
						"危险之中，错综复杂的世界，他们将面对诸多敌人，\n",
						"随时随地准备对抗迎面而来的袭击。\n \n",
						"操作方法:\n",
						"瞄准:滑动屏幕移动准星。\n",
						"射击:点击右下角射击按钮开枪，长按可连续射击。\n",
						"手雷:瞄准敌人后，点击手雷按钮。\n",
						"盾牌:点击防爆盾牌图标，可抵挡敌人的攻击，使用盾\n",
						"牌时可以继续攻击。\n",
						"机甲变身:点击屏幕右上方的机甲按钮，驾驶机甲，可\n",
						"免受任何伤害。\n",
						"黄金变身:点击黄金变身按钮，对敌人造成巨大伤害。\n \n",
						"功能界面:\n",
						"点击关卡图标:进入准备界面。\n",
						"武器库:购买各种武器，玩家可以选择2把武器带入战\n",
						"斗。\n",
						"武器升级:花费金币提高武器的属性。\n",
						"镶嵌:为武器镶嵌各种零件，额外提高武器能力，战斗\n",
						"结束后零件消失。\n",
						"商城:花费购买各种道具。\n"
						}
		self.text = "";
		for k,v in pairs(text) do
			self.text = self.text..v
		end
		
	end
end

function AboutPopup:initContent()
	if self.popupName == "bangzhu" then
		local textLabel = cc.uiloader:seekNodeByName(self.aboutNode, "context")
		textLabel:setString(self.text)
	end
end



return AboutPopup