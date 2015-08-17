local ActJujiNode   = import("..jujiMode.JujiModeLayer")
local ActBossNode   = import("..bossMode.BossModeLayer")
local DailyTaskNode = import("..dailyTask.DailyTaskLayer")

local ActivitysMainLayer = class("ActivitysMainLayer", function()
	return display.newLayer()
end)

function ActivitysMainLayer:ctor()
	
end

function ActivitysMainLayer:onShow(data)
    self.property = data
    if self.ui == nil then 
        self:loadCCS()
    end

    --start
    self:refreshListView(self.property["selectId"])
end

function ActivitysMainLayer:loadCCS()
    self.ui = cc.uiloader:load("res/huodong/huodong.ExportJson")
    self:addChild(self.ui)

    --comment
    self.comment = cc.uiloader:seekNodeByName(self.ui, "layer_comment")

    --btns
    self.btn_dailyTask = cc.uiloader:seekNodeByName(self.ui, "btn_dailyTask")
    self.btn_dailyTask:onButtonClicked(function ()
    	self:refreshListView("dailyTask")
    end)


    --juji
    self.btn_juji = cc.uiloader:seekNodeByName(self.ui, "btn_juji")
    local userModel = md:getInstance("UserModel")
    local isOpenJuji = userModel:getUserLevel() >= 5
    if not isOpenJuji then
        self.btn_juji:setButtonImage(self.btn_juji.NORMAL, "#btn_wuxianjuji4.png")
        self.btn_juji:setButtonImage(self.btn_juji.PRESSED, "#btn_wuxianjuji4.png")
        self.btn_juji:onButtonClicked(function( event )
            ui:showPopup("commonPopup",
                     {type = "style2", content = "通过狙击关卡后开启！"},
                     {opacity = 0})
        end)  
    else
        self.btn_juji:onButtonClicked(function( event )
            
            self:refreshListView("jujiFight")
        end) 
    end



    --boss

    self.btn_boss = cc.uiloader:seekNodeByName(self.ui, "btn_boss")
    local userModel = md:getInstance("UserModel")
    local isOpenBoss = userModel:getUserLevel() >= 7
    if not isOpenBoss then
        self.btn_boss:setButtonImage(self.btn_boss.NORMAL, "#btn_wuxianboss4.png")
        self.btn_boss:setButtonImage(self.btn_boss.PRESSED, "#btn_wuxianboss4.png")

        self.btn_boss:onButtonClicked(function( event )
            ui:showPopup("commonPopup",
                     {type = "style2", content = "通关第一章后开启！"},
                     {opacity = 0})
        end)
    else
        self.btn_boss:onButtonClicked(function( event )
               self:refreshListView("bossFight")
        end)
    end
end

function ActivitysMainLayer:refreshListView(type)
    self.btn_juji:setButtonEnabled(true)
    self.btn_boss:setButtonEnabled(true)
    self.btn_dailyTask:setButtonEnabled(true)
    print("function ActivitysMainLayer:refreshListView(type)")
    self.comment:removeAllChildren()

    local contentNode = nil
    if type == "jujiFight" then 
        self.btn_juji:setButtonEnabled(false)
        contentNode = ActJujiNode.new()
    elseif type == "bossFight" then 
        self.btn_boss:setButtonEnabled(false)
        local bossModeModel = md:getInstance("BossModeModel")
        local chapterIndex = bossModeModel:getAlreadyChapter()
        contentNode = ActBossNode.new({chapterIndex = chapterIndex})
    elseif type == "dailyTask" then 
        self.btn_dailyTask:setButtonEnabled(false)
        contentNode = DailyTaskNode.new()
    else
        assert(false, "type is invalid" .. type)
    end

    self.comment:addChild(contentNode)
end

return ActivitysMainLayer