import("..includes.functionUtils")

local LevelDetailModel = import(".LevelDetailModel")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local LevelDetailLayer = class("LevelDetailLayer", function()
	return display.newLayer()
end)

function LevelDetailLayer:ctor(index1, index2)
	--model
	self.model = app:getInstance(LevelDetailModel)

	self:loadCCS()
	self:initData(index1, index2)	
	self:initUI()
end

function LevelDetailLayer:initUI()
	-- seek btn
	local btnOff   = cc.uiloader:seekNodeByName(self, "btn_off")
	local btnStart = cc.uiloader:seekNodeByName(self, "btn_start")
	local btnBibei = cc.uiloader:seekNodeByName(self, "btn_bibei")
	local btnGold  = cc.uiloader:seekNodeByName(self, "btn_gold")
	local btnJijia = cc.uiloader:seekNodeByName(self, "btn_jijia")

	-- seek label
	local lblTitle    = cc.uiloader:seekNodeByName(self, "label_title")
	local lblId       = cc.uiloader:seekNodeByName(self, "label_id")
	local lblTask     = cc.uiloader:seekNodeByName(self, "label_task")
	local lblEnemyNum = cc.uiloader:seekNodeByName(self, "label_total")
	local lblTasktype = cc.uiloader:seekNodeByName(self, "label_tasktype")
	self.lblTitle    = lblTitle
	self.lblId       = lblId
	self.lblTask     = lblTask
	self.lblEnemyNum = lblEnemyNum
	self.lblTasktype    = lblTasktype

	-- seek layer for image
	local lyrMap   = cc.uiloader:seekNodeByName(self, "layer_mapimage")
	local lyrBibei = cc.uiloader:seekNodeByName(self, "layer_bibei")
	local lyrGold  = cc.uiloader:seekNodeByName(self, "layer_gold")
	local lyrJijia = cc.uiloader:seekNodeByName(self, "layer_jijia")
    self.lyrMap   = lyrMap
    self.lyrBibei = lyrBibei
    self.lyrGold  = lyrGold
    self.lyrJijia = lyrJijia

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
end

function LevelDetailLayer:onClickBtnBibei()
	print("bibeibtn is clicked!")
end

function LevelDetailLayer:onClickBtnGold()
	print("goldbtn is clicked!")
	dump(GameState.load(GameData))
end

function LevelDetailLayer:onClickBtnJijia()
	print("jijiabtn is clicked!")
end

---- initData ----
function LevelDetailLayer:initData(BigID,SmallID)
	local DataTable = LevelDetailModel:getConfig(BigID,SmallID)

	--Label
	self.lblTitle:setString(DataTable["guanqiaName"])
	self.lblId:setString(DataTable["guanqiaNum"])
	self.lblTask:setString(DataTable["task"])
	self.lblEnemyNum:setString("共"..DataTable["enemyNum"].."波")
	self.lblTasktype:setString(DataTable["taskType"])

	--Image
	--map从所有map里找寻，配表内填写为地图名，待修改
	--gun从所有gun里找寻，配表内填写为枪名，待修改
	local mapimg = cc.ui.UIImage.new("LevelDetail/"..DataTable["mapxiaoImg"]..".png")
	local jijiaimg = cc.ui.UIImage.new("LevelDetail/"..DataTable["jijia"]..".png")
	local goldimg = cc.ui.UIImage.new("LevelDetail/"..DataTable["gold"]..".png")
	local weaponimg = cc.ui.UIImage.new("LevelDetail/"..DataTable["weapon"]..".png")

	addChildCenter(mapimg, self.lyrMap)
	addChildCenter(jijiaimg, self.lyrJijia)
	addChildCenter(goldimg, self.lyrGold)
	addChildCenter(weaponimg, self.lyrBibei)
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