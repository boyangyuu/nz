
--[[--

“推荐提示”的视图

]]

local FightAdvisePopup = class("FightAdvisePopup", function()
    return display.newLayer()
end)


--[[
    type : 画布名称
    cost : 钻石数目
    gunId : 枪ID
]]
function FightAdvisePopup:ctor(property)
	--instance
    self.buyModel = md:getInstance("BuyModel")
	self.buyModel = md:getInstance("BuyModel")
	self.property = property    
	self.type     = property["type"]
    self:setNodeEventEnabled(true) 
end

function FightAdvisePopup:onEnter()
	self:onShow()
end

function FightAdvisePopup:loadCCS()
    local manager = ccs.ArmatureDataManager:getInstance() 
	local srcStr = "res/tuijian/".. self.type .. ".json"
	self.node = cc.uiloader:load(srcStr)
    self:addChild(self.node)    

    --btns
    local btnConfirm = cc.uiloader:seekNodeByName(self.node, "btnConfirm")
    btnConfirm:onButtonClicked(function()
         self:onClickConfirm()
    end)
    local btnCancel = cc.uiloader:seekNodeByName(self.node, "btnCancel")
    btnCancel:onButtonClicked(function()
         self:onClickCancel()
    end)
end

function FightAdvisePopup:onShow()
	self:loadCCS()
end

function FightAdvisePopup:onClickConfirm()

    self:buyWeapon()
end

function FightAdvisePopup:buyWeapon()
    local user = md:getInstance("UserModel")
    local isAfforded = user:costDiamond(self.property["cost"], true, "xx模式_钻石购买".. self.type) 
    if not isAfforded then return end
	
	--装备上
    if self.type == "goldJijia" then 
        self:onEquipRobot()
    else 
        self:onEquipGun()
    end

    self:closePopup()
end

function FightAdvisePopup:onEquipRobot()
    local robot = md:getInstance("Robot")
    robot:startGoldRobot()
end

function FightAdvisePopup:onEquipGun()
    local gunId = self.property["gunId"]
    assert(gunId, "gunId is nil")

    --buy

    --weaponListModel
    local fightGun = md:getInstance("FightGun")
    fightGun:buyGun(gunId)  
end

function FightAdvisePopup:onClickCancel()
	self:closePopup()
end

function FightAdvisePopup:closePopup()
	ui:closePopup("FightAdvisePopup", {animName = "normal"})
end

return FightAdvisePopup