
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
end

function DailyTaskLayer:initListUI()
    local datas = self.model:getSortedDatas()   
    dump(datas, "DailyTaskLayer:initListUI() datas")
    for i,data in ipairs(datas) do
        local item = self.listTasks:newItem()
        local content = DailyTaskCell.new(data["index"])
        item:addContent(content)
        item:setItemSize(910, 115)
        self.listTasks:addItem(item)
    end
    self.listTasks:reload()    
end

return DailyTaskLayer