import("..includes.functionUtils")

local LevelDetailModel = import(".LevelDetailModel")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local FightPlayer = import("..fight.FightPlayer")

local LevelDetailLayer = class("LevelDetailLayer", function()
	return display.newLayer()
end)

function LevelDetailLayer:ctor(index1, index2)
	--model
	self.model = app:getInstance(LevelDetailModel)

	self:loadCCS()
	self:initUI()
	self:initData(index1, index2)
end

function LevelDetailLayer:initUI()
	-- seek btn
	local btnOff   = cc.uiloader:seekNodeByName(self, "btn_off")
	local btnStart = cc.uiloader:seekNodeByName(self, "btn_start")
	local btnBibei = cc.uiloader:seekNodeByName(self, "btn_bibei")
	local btnGold  = cc.uiloader:seekNodeByName(self, "btn_gold")
	local btnJijia = cc.uiloader:seekNodeByName(self, "btn_jijia")

	-- seek label
	self.labelTitle    = cc.uiloader:seekNodeByName(self, "label_title")
	self.labelId       = cc.uiloader:seekNodeByName(self, "label_id")
	self.labelTask     = cc.uiloader:seekNodeByName(self, "label_task")
	self.labelEnemyNum = cc.uiloader:seekNodeByName(self, "label_total")
	self.labelTasktype = cc.uiloader:seekNodeByName(self, "label_tasktype")

	-- seek layer for image
	self.layerMap   = cc.uiloader:seekNodeByName(self, "layer_mapimage")
	self.layerBibei = cc.uiloader:seekNodeByName(self, "layer_bibei")
	self.layerGold  = cc.uiloader:seekNodeByName(self, "layer_gold")
	self.layerJijia = cc.uiloader:seekNodeByName(self, "layer_jijia")

	-- set touch enable
	btnOff   :setTouchEnabled(true)
	btnStart :setTouchEnabled(true)
	btnBibei :setTouchEnabled(true)
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
    app:getInstance(PopupCommonLayer):onExit()
end

function LevelDetailLayer:onClickBtnStart()
	print("startbtn is clicked!")
	local scene = display.newScene("FightScene")
	local FightPlayer = FightPlayer.new()
	scene:addChild(FightPlayer)
	display.replaceScene(scene)
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

---- initData ----
function LevelDetailLayer:initData(gropID,levelID)
	local DataTable = self.model:getConfig(gropID,levelID)

	--Label

	self.labelTitle:setString(DataTable["guanqiaName"])
	self.labelId:setString(DataTable["daguanqia"].."-"..DataTable["xiaoguanqia"])
	self.labelTask:setString(DataTable["task"])
	self.labelEnemyNum:setString("共"..DataTable["enemyNum"].."波")
	self.labelTasktype:setString(DataTable["taskType"])


	--Image
	--map从所有map里找寻，配表内填写为地图名，待修改
	--gun从所有gun里找寻，配表内填写为枪名，待修改
	local mapImg=cc.ui.UIImage.new("LevelDetail/"..DataTable["mapxiaoImg"]..".png")
	local jijiaImg=cc.ui.UIImage.new("LevelDetail/"..DataTable["jijia"]..".png")
	local goldImg=cc.ui.UIImage.new("LevelDetail/"..DataTable["gold"]..".png")
	local weaponImg=cc.ui.UIImage.new("LevelDetail/"..DataTable["weapon"]..".png")

	addChildCenter(mapImg   , self.layerMap)
	addChildCenter(jijiaImg , self.layerJijia)
	addChildCenter(goldImg  , self.layerGold)
	addChildCenter(weaponImg, self.layerBibei)
end


function LevelDetailLayer:loadCCS()
	-- load control bar
	cc.FileUtils:getInstance():addSearchPath("res/LevelDetail")
	local controlNode = cc.uiloader:load("LevelDetail.ExportJson")
	-- controlNode:setPosition(0, 0)
    self.ui = controlNode
    self:addChild(controlNode)
end
function LevelDetailLayer:onExit()

end

return LevelDetailLayer