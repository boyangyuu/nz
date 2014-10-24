import("..includes.functionUtils")

local LevelDetailLayer = class("LevelDetailLayer", function()
	return display.newLayer()
end)

function LevelDetailLayer:ctor()
	self:onEnter()
	-- self.guanqiaNameLabel:setString("hello")
end

function LevelDetailLayer:onEnter()
	self:loadCCS()

	-- seek btn
	local btnOff    = cc.uiloader:seekNodeByName(self, "btn_off")
	local btnStart  = cc.uiloader:seekNodeByName(self, "btn_start")
	local btnBibei   = cc.uiloader:seekNodeByName(self, "btn_bibei")
	local btnGold  = cc.uiloader:seekNodeByName(self, "btn_gold")
	local btnJijia = cc.uiloader:seekNodeByName(self, "btn_jijia")

	-- seek label
	local lblTitle = cc.uiloader:seekNodeByName(self, "label_title")
	local lblId  = cc.uiloader:seekNodeByName(self, "label_id")
	local lblTask        = cc.uiloader:seekNodeByName(self, "label_task")
	local lblEnemyNum    = cc.uiloader:seekNodeByName(self, "label_total")
	local lblTasktype    = cc.uiloader:seekNodeByName(self, "label_tasktype")

	self.lblTitle = lblTitle
	self.lblId  = lblId
	self.lblTask        = lblTask
	self.lblEnemyNum    = lblEnemyNum
	self.lblTasktype    = lblTasktype

	-- seek layer for image
	local lyrMap = cc.uiloader:seekNodeByName(self, "layer_mapimage")
	local lyrBibei    = cc.uiloader:seekNodeByName(self, "layer_bibei")
	local lyrGold   = cc.uiloader:seekNodeByName(self, "layer_gold")
	local lyrJijia = cc.uiloader:seekNodeByName(self, "layer_jijia")
	-- self.ImageMapxiao=ImageMapxiao
		self:removeChild(ImageMapxiao)

	

	-- set touch enable
	btnOff    :setTouchEnabled(true)
	btnStart  :setTouchEnabled(true)
	btnBibei   :setTouchEnabled(true)
	btnGold  :setTouchEnabled(true)
	btnJijia :setTouchEnabled(true)


	------ on btn clicked
	--offbtn
	addBtnEventListener(btnOff, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnOff()
        end
    end)
    --startbtn
    addBtnEventListener(btnStart, function(event)
        if event.name=='began' then
            print("startbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnStart()
        end
    end)
    --bibei
    addBtnEventListener(btnBibei, function(event)
        if event.name=='began' then
            print("bibeibtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnBibei()
        end
    end)
    --gold
    addBtnEventListener(btnGold, function(event)
        if event.name=='began' then
            print("btngold is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnGold()
        end
    end)
    --jijia
    addBtnEventListener(btnJijia, function(event)
        if event.name=='began' then
            print("btnJijia is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnJijia()
        end
    end)
	

end

----btn----
function LevelDetailLayer:onClickBtnOff()

		local node = cc.ui.UIImage.new("res/anim_btnFire020.png")

	print("offbtn is clicked!")
end

function LevelDetailLayer:onClickBtnStart()
	print("startbtn is clicked!")
end

function LevelDetailLayer:onClickBtnBibei()
	print("bibeibtn is clicked!")
end

function LevelDetailLayer:onClickBtnGold()
	print("goldbtn is clicked!")
end

function LevelDetailLayer:onClickBtnJijia()
	print("jijiabtn is clicked!")
end



function LevelDetailLayer:loadCCS()
	-- load control bar
	cc.FileUtils:getInstance():addSearchPath("res/LevelDetail")
	local controlNode = cc.uiloader:load("LevelDetail.ExportJson")
	-- controlNode:setPosition(0, 0)
    self.ui = controlNode
    self:addChild(controlNode, 1000)
end
function LevelDetailLayer:onExit()

end

return LevelDetailLayer