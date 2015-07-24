local ActJujiNode   = import("..jujiMode.JujiModeLayer")
local ActBossNode   = import("..bossMode.BossModeLayer")
local DailyTaskNode = import("..dailyTask.DailyTaskLayer")
local ActKillNode   = import("..killMode.KillModeLayer")

local ActivitysMainLayer = class("ActivitysMainLayer", function()
	return display.newLayer()
end)

function ActivitysMainLayer:ctor()
	
end

function ActivitysMainLayer:onShow()
    if self.ui == nil then 
        self:loadCCS()
    end

    --start
    self:refreshListView("dailyTask")
end

function ActivitysMainLayer:loadCCS()
    self.ui = cc.uiloader:load("res/huodong/huodong.ExportJson")
    self:addChild(self.ui)

    --comment
    self.comment = cc.uiloader:seekNodeByName(self.ui, "layer_comment")

    --btns
    local btn_dailyTask = cc.uiloader:seekNodeByName(self.ui, "btn_dailyTask")
    btn_dailyTask:onButtonClicked(function ()
    	self:refreshListView("dailyTask")
    end)

    local btn_juji = cc.uiloader:seekNodeByName(self.ui, "btn_juji")
    btn_juji:onButtonClicked(function ()
    	self:refreshListView("juji")
    end)

    local btn_kill = cc.uiloader:seekNodeByName(self.ui, "btn_kill")
    btn_kill:onButtonClicked(function ()
        self:refreshListView("kill")
    end)

    local btn_boss = cc.uiloader:seekNodeByName(self.ui, "btn_boss")
    btn_boss:onButtonClicked(function ()
        self:refreshListView("boss")
    end)    
end

function ActivitysMainLayer:refreshListView(type)
    print("function ActivitysMainLayer:refreshListView(type)")
    self.comment:removeAllChildren()

    local contentNode = nil
    if type == "juji" then 
        contentNode = ActJujiNode.new()
    elseif type == "boss" then 
        local bossModeModel = md:getInstance("BossModeModel")
        local chapterIndex = bossModeModel:getAlreadyChapter()
        contentNode = ActBossNode.new({chapterIndex = chapterIndex})
    elseif type == "dailyTask" then 
        contentNode = DailyTaskNode.new()
    elseif type == "kill" then 
        contentNode = ActKillNode.new()
    else
        assert(false, "type is invalid" .. type)
    end

    self.comment:addChild(contentNode)
end

return ActivitysMainLayer