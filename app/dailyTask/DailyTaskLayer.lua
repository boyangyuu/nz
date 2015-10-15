
local DailyTaskCell   = import(".DailyTaskCell")


local DailyTaskLayer = class("DailyTaskLayer", function()
	return display.newLayer()
end)

function DailyTaskLayer:ctor()
    --instance
    self.model = md:getInstance("DailyTaskModel")
	self:loadCCS()
	self:initUI()

    local data = getUserData()
    dump(data.dailyTask.awardedTasks, "ata.dailyTask.awardedTasks")
end

function DailyTaskLayer:loadCCS()
    self.ui = cc.uiloader:load("dailyTask/dailyTask.ExportJson")
    self:addChild(self.ui)
    self.listTasks = cc.uiloader:seekNodeByName(self.ui, "listTasks")
end

function DailyTaskLayer:initUI()
    self:initListUI()
    self:checkNetWork()
end

function DailyTaskLayer:checkNetWork()
    local isAvailable = network.isInternetConnectionAvailable()
    if isAvailable then
        print("network isAvailable")
    else
        ui:showPopup("commonPopup",
             {type = "style1",content = LanguageManager.getStringForKey("string_hint50"),},
             {opacity = 0})
    end
end

function DailyTaskLayer:initListUI()
    local datas = self.model:getSortedDatas()
    for i,data in ipairs(datas) do
        local item = self.listTasks:newItem()
        local content = DailyTaskCell.new(data["index"])
        item:addContent(content)
        item:setItemSize(900, 90)
        self.listTasks:addItem(item)
    end
    self.listTasks:reload()
end

return DailyTaskLayer