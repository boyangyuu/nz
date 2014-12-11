import("..includes.functionUtils")
local LevelDetailModel = import(".LevelDetailModel")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local WeaponListModel = import("..weaponList.WeaponListModel")

local LevelDetailLayer = class("LevelDetailLayer", function()
	return display.newLayer()
end)

function LevelDetailLayer:ctor(properties)
	--model
	self.model = app:getInstance(LevelDetailModel)
	self.weaponListModel = app:getInstance(WeaponListModel)

	self:loadCCS()
	self:initUI()
	self:initData(properties.groupId, properties.levelId)
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
	self.labeldesc     = cc.uiloader:seekNodeByName(self, "label_desc")
	self.labelTasktype = cc.uiloader:seekNodeByName(self, "label_tasktype")
	self.labelget = cc.uiloader:seekNodeByName(self, "levelget")
	self.panelbiaozhu = cc.uiloader:seekNodeByName(self, "panelbiaozhu")

	-- seek layer for image
	self.layerMap   = cc.uiloader:seekNodeByName(self, "mapimage")
	self.layerBibei = cc.uiloader:seekNodeByName(self, "bibeiimg")


	local dansedijj = cc.uiloader:seekNodeByName(self, "dansedijj")
	local dansejj = cc.uiloader:seekNodeByName(self, "dansejj")	
	local dansedihw = cc.uiloader:seekNodeByName(self, "dansedihw")
	local dansehw = cc.uiloader:seekNodeByName(self, "dansehw")
	local danseditj = cc.uiloader:seekNodeByName(self, "danseditj")
	local dansetj = cc.uiloader:seekNodeByName(self, "dansetj")
	dansedijj:setColor(cc.c3b(249,0,255))
	dansejj:setColor(cc.c3b(249,0,255))
	dansedihw:setColor(cc.c3b(255,208,0))
	dansehw:setColor(cc.c3b(255,208,0))
	danseditj:setColor(cc.c3b(0,255,198))
	dansetj:setColor(cc.c3b(0,255,198))
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
            -- print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnOff()
        end
    end)
    --startbtn
    addBtnEventListener(btnStart, function(event)
        if event.name=='began' then
            -- print("startbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnStart()
        end
    end)
    --bibei
    addBtnEventListener(btnBibei, function(event)
        if event.name=='began' then
            -- print("bibeibtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnBibei()
        end
    end)
    --gold
    addBtnEventListener(btnGold, function(event)
        if event.name=='began' then
            -- print("btngold is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnGold()
        end
    end)
    --jijia
    addBtnEventListener(btnJijia, function(event)
        if event.name=='began' then
            -- print("btnJijia is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnJijia()
        end
    end)
end

----btn----
function LevelDetailLayer:onClickBtnOff()
    ui:closePopup()
end

function LevelDetailLayer:onClickBtnStart()
	print("startbtn is clicked!")
	ui:changeLayer("FightPlayer", {})
	self:onClickBtnOff()
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
function LevelDetailLayer:initData(groupID,levelID)
	local DataTable = self.model:getConfig(groupID,levelID)

	--Label

	self.labelTitle:setString(DataTable["name"])
	self.labelId:setString(DataTable["groupId"].."-"..DataTable["levelId"])
	self.labeldesc:setString(DataTable["desc"])
	self.labelTasktype:setString(DataTable["taskTypeDesc"])
	self.labelget:setVisible(false)
	self.panelbiaozhu:setVisible(false)
	local isWeaponAlreadyTogether = self.weaponListModel:isWeaponExist(DataTable["suipianid"])
	if DataTable["type"] == "boss" and isWeaponAlreadyTogether == false then
		self.labelget:setVisible(true)
		self.panelbiaozhu:setVisible(true)
		self.labelget:setString("本关卡可获得"..self.weaponListModel:getWeaponNameByID(DataTable["suipianid"])
			.."零件1个，当前"..self.model:getSuiPianNum(DataTable["suipianid"]).."/5")
	end

	local mapSrcName = "map_"..groupID.."_"..levelID..".json"   -- todo 外界
    cc.FileUtils:getInstance():addSearchPath("res/Fight/Maps")

    local node = cc.uiloader:load(mapSrcName)
	local map = node
	map:setScale(0.47, 0.48)
	local mapimg = cc.uiloader:seekNodeByName(self, "mapimage")
	mapimg:addChild(map)

	local weaponimg = display.newSprite("#icon_"..DataTable["weapon"]..".png")
	weaponimg:setScale(0.56)
	local bibeiimg = cc.uiloader:seekNodeByName(self, "bibeiimg")
	addChildCenter(weaponimg, bibeiimg)
end


function LevelDetailLayer:loadCCS()
	-- load control bar
	cc.FileUtils:getInstance():addSearchPath("res/LevelDetail/guanqiapingjia")
	local controlNode = cc.uiloader:load("guanqiakaishi.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)
end

function LevelDetailLayer:onExit()

end

return LevelDetailLayer