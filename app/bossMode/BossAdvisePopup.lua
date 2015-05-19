
--[[--

“推荐提示”的视图

]]

local BossAdvisePopup = class("BossAdvisePopup", function()
    return display.newLayer()
end)


--[[
    type : 画布名称
]]
function BossAdvisePopup:ctor(property)
	self.type     = property["type"]
    self:setNodeEventEnabled(true) 
end

function BossAdvisePopup:onEnter()
	self:onShow()
end

function BossAdvisePopup:loadCCS()
    local manager = ccs.ArmatureDataManager:getInstance() 
	local srcStr = "res/tuijian/".. self.type .. ".json"
	self.node = cc.uiloader:load(srcStr)
    self:addChild(self.node)    

    --btns
    local btnConfirm = cc.uiloader:seekNodeByName(self.node, "btnConfirm")
    btnConfirm:onButtonClicked(function()
         self:onClickConfirm()
    end)
end

function BossAdvisePopup:onShow()
	self:loadCCS()
end

function BossAdvisePopup:onClickConfirm()
    self:closePopup()
end

function BossAdvisePopup:closePopup()
	ui:closePopup("BossAdvisePopup", {animName = "normal"})
end

return BossAdvisePopup