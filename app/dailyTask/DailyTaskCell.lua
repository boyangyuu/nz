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
	self.ui:setPosition(0, 0)
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
	label_awardNum:setString("X"..awardValue)

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
	local label_jl = cc.uiloader:seekNodeByName(self.ui, "jiangli")


    function setUI()
        bg2:setVisible(true)
        label_str:setColor(cc.c3b(111, 31, 61))
        label_jl:setColor(cc.c3b(121, 31, 61))
        label_jl:setPosition(cc.p(300, 30))
        progress:setVisible(false)
        icon_gold:setPosition(cc.p(390, 25))
        icon_diamond:setPosition(cc.p(390, 25))
        icon_gold:setScale(0.8)
        icon_diamond:setScale(0.8)
        label_awardNum:setPosition(cc.p(420, 30))
        label_awardNum:setColor(cc.c3b(111, 31, 61))
    end
    if isGetted then
    	setUI()
    	btn:setButtonEnabled(false)
    elseif isCanGet then
        setUI()
    else
    	bg1:setVisible(true)
    	btn:setVisible(false)
    end

	btn:onButtonClicked(function()
        local isAvailable = network.isInternetConnectionAvailable()
        if isAvailable then
            self:onClickGet()
        else
            ui:showPopup("commonPopup",
                 {type = "style1",content = LanguageManager.getStringForKey("string_hint49")},
                 {opacity = 0})
        end
    end)
end

function DailyTaskCell:checkNetWork()
    local isAvailable = network.isInternetConnectionAvailable()
    if isAvailable then
        print("network isAvailable")
    else
        ui:showPopup("commonPopup",
             {type = "style1",content = LanguageManager.getStringForKey("string_hint50")},
             {opacity = 0})
    end
end

function DailyTaskCell:onClickGet()
	local isCanGet = self.property["isCanGet"]
	local isGetted = self.property["isGetted"]
    local str = ""
    if isGetted then
        str = LanguageManager.getStringForKey("string_hint51")
    elseif isCanGet then
    	self.model:receiveTaskAward(self.property["index"])
        str = LanguageManager.getStringForKey("string_hint6")
        self:refreshUI()
    else
        str = LanguageManager.getStringForKey("string_hint52")
    end

    ui:showPopup("commonPopup",{type = "style2",content = str, delay = 2},
         {opacity = 100})
end

return DailyTaskCell