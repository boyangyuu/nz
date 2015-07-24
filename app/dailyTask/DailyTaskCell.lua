local DailyTaskConfig = import(".DailyTaskConfig")


local DailyTaskCell = class("DailyTaskCell", function()
	return display.newNode()
end)

function DailyTaskCell:ctor(index)
	--instance
	self.model = md:getInstance("DailyTaskModel")
	self.index = index
	self:loadCCS()
	self:refreshUI()
end

function DailyTaskCell:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/dailyTask/") 
end

function DailyTaskCell:refreshUI()
	--ui
	if self.ui then 
		self.ui:removeSelf()
	end
	self.ui = cc.uiloader:load("res/dailyTask/item.ExportJson")
    self:addChild(self.ui)  	

    self.property = self.model:getTaskData(self.index)
	--label
	local str = self.property["str"]
	local label_str = cc.uiloader:seekNodeByName(self.ui, "label_str")
	label_str:setString(str)

	--award
	local isAwardDiamond = self.property["awardType"] == "diamond"
	local icon_gold      = cc.uiloader:seekNodeByName(self.ui, "icon_gold")
	local icon_diamond   = cc.uiloader:seekNodeByName(self.ui, "icon_diamond")
	icon_diamond:setVisible(isAwardDiamond)
	icon_gold:setVisible(not isAwardDiamond)

	--award value
	local awardValue     = self.property["awardValue"]
	local label_awardNum = cc.uiloader:seekNodeByName(self.ui, "awardNum")
	label_awardNum:setString(awardValue)

	--progress
	local pers = self.property["curValue"] / self.property["limit"] * 100
	if pers >= 100 then pers = 100 end
	local progress = cc.uiloader:seekNodeByName(self.ui, "progress")
	progress:setPercent(pers)
	
	--can get
	local isCanGet = self.property["isCanGet"]
	local isGetted = self.property["isGetted"]
	local bg1    = cc.uiloader:seekNodeByName(self.ui, "bg1")
	local bg2    = cc.uiloader:seekNodeByName(self.ui, "bg2")
	local btn    = cc.uiloader:seekNodeByName(self.ui, "btnGet")

    if isGetted then 
    	bg2:setVisible(true)
    	btn:setButtonImage(btn.NORMAL, "btn_rwlingqu_3.png")
    elseif isCanGet then 
    	bg2:setVisible(true)
    	btn:setButtonImage(btn.NORMAL, "btn_rwlingqu_1.png")
    else
    	bg1:setVisible(true)
    	btn:setButtonImage(btn.NORMAL, "btn_rwlingqu_2.png")
    end

	btn:onButtonClicked(function()
         self:onClickGet()
    end)
end

function DailyTaskCell:onClickGet()
	local isCanGet = self.property["isCanGet"]
	local isGetted = self.property["isGetted"]
    local str = ""
    if isGetted then 
        str = "已领取！"
    elseif isCanGet then 
    	self.model:receiveTaskAward(self.property["index"])
        str = "领取成功！"
        self:refreshUI()
    else
        str = "未完成，无法领取！"
    end	

    ui:showPopup("commonPopup",{type = "style2",content = str, delay = 2},
         {opacity = 100})    		
end

return DailyTaskCell