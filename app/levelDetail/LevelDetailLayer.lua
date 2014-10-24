local ViewUtils = import("..ViewUtils")
local DataUtils = import("..DataUtils")

local LevelDetailLayer = class("LevelDetailLayer", function()
	return display.newLayer()
end)

function LevelDetailLayer:ctor()
	self:onEnter()
	-- self.guanqiaNameLabel:setString("hello")
end

function LevelDetailLayer:onEnter()
	self:loadCCS()

	-- seek button
	local ButtonOff    = cc.uiloader:seekNodeByName(self, "btn_guanqia_off")
	local ButtonStart  = cc.uiloader:seekNodeByName(self, "btn_startgame")
	local ButtonYjzb   = cc.uiloader:seekNodeByName(self, "btn_yjzb")
	local ButtonYjhq   = cc.uiloader:seekNodeByName(self, "btn_yjhq")
	local ButtonYjhq02 = cc.uiloader:seekNodeByName(self, "btn_yjhq02")

	-- seek label
	local LabelGuanqiaName = cc.uiloader:seekNodeByName(self, "label_guanqianame")
	local LabelGuanqiaNum  = cc.uiloader:seekNodeByName(self, "label_guanqianum")
	local LabelTask        = cc.uiloader:seekNodeByName(self, "label_task_text")
	local LabelEnemyNum    = cc.uiloader:seekNodeByName(self, "label_enemynum_text")
	local LabelTasktype    = cc.uiloader:seekNodeByName(self, "label_tasktype_text")

	self.LabelGuanqiaName = LabelGuanqiaName
	self.LabelGuanqiaNum  = LabelGuanqiaNum
	self.LabelTask        = LabelTask
	self.LabelEnemyNum    = LabelEnemyNum
	self.LabelTasktype    = LabelTasktype

	-- seek image
	local ImageTuijian = cc.uiloader:seekNodeByName(self, "icon_tuijian_guanqia001")
	local ImageHjwq    = cc.uiloader:seekNodeByName(self, "icon_hjwu")
	local ImageJijia   = cc.uiloader:seekNodeByName(self, "icon_jijia")
	local ImageMapxiao = cc.uiloader:seekNodeByName(self, "mapxiao_guanqia001")
	-- self.ImageMapxiao=ImageMapxiao
		self:removeChild(ImageMapxiao)

	

	-- set touch enable
	ButtonOff    :setTouchEnabled(true)
	ButtonStart  :setTouchEnabled(true)
	ButtonYjzb   :setTouchEnabled(true)
	ButtonYjhq   :setTouchEnabled(true)
	ButtonYjhq02 :setTouchEnabled(true)


	------ on btn clicked
	--offButton
	ViewUtils:addBtnEventListener(ButtonOff, function(event)
        if event.name=='began' then
            print("offButton is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnOff()
        end
    end)
    --startButton
    ViewUtils:addBtnEventListener(ButtonStart, function(event)
        if event.name=='began' then
            print("startButton is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnStart()
        end
    end)
    --yjzbButton
    ViewUtils:addBtnEventListener(ButtonYjzb, function(event)
        if event.name=='began' then
            print("yjzbButton is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnYJZB()
        end
    end)
    --yjhqButton
    ViewUtils:addBtnEventListener(ButtonYjhq, function(event)
        if event.name=='began' then
            print("yjhqButton is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnYJHQ()
        end
    end)
    --yjhq02Button
    ViewUtils:addBtnEventListener(ButtonYjhq02, function(event)
        if event.name=='began' then
            print("yjhq02Button is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnYJHQ02()
        end
    end)
	

end

----btn----
function LevelDetailLayer:onClickBtnOff()

	-- DataUtils:getConfigByID("config/tet.json",3)
-- 		local node = cc.ui.UIImage.new("res/anim_btnFire020.png")
-- dump(node)
-- 	self.ImageMapxiao:createImage(node)
	-- self:removeChild(self.ImageMapxiao)
	print("offButton is clicked!")
end

function LevelDetailLayer:onClickBtnStart()
	print("startButton is clicked!")
end

function LevelDetailLayer:onClickBtnYJZB()
	print("yjzbButton is clicked!")
end

function LevelDetailLayer:onClickBtnYJHQ()
	print("yjhqButton is clicked!")
end

function LevelDetailLayer:onClickBtnYJHQ02()
	print("yjhq02Button is clicked!")
end



function LevelDetailLayer:loadCCS()
	-- load control bar
	cc.FileUtils:getInstance():addSearchPath("res/LevelDetail")
	local controlNode = cc.uiloader:load("guanqiaxiangqing001_1.ExportJson")
	-- controlNode:setPosition(0, 0)
    self.ui = controlNode
    self:addChild(controlNode, 2)
end
function LevelDetailLayer:onExit()

end

return LevelDetailLayer