import("..includes.functionUtils")

local LevelDetailLayer = class("LevelDetailLayer", function()
	return display.newLayer()
end)

function LevelDetailLayer:ctor(properties)
	--instance
	self.model = md:getInstance("LevelDetailModel")
	self.weaponListModel = md:getInstance("WeaponListModel")
	self.groupId = properties.groupId
	print("self.groupId,", self.groupId)
	self.levelId = properties.levelId
	self:initData()
	
	--ui
	self:loadCCS()
	self:initUI()


end

function LevelDetailLayer:loadCCS()
	-- load control bar
	cc.FileUtils:getInstance():addSearchPath("res/LevelDetail")
	local controlNode = cc.uiloader:load("guanqiakaishi.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)

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
	self.panlEnemy = cc.uiloader:seekNodeByName(self, "panlenemy")   

	-- seek already image
	self.alreadybibei   = cc.uiloader:seekNodeByName(self, "alreadybibei")
	self.alreadygold   = cc.uiloader:seekNodeByName(self, "alreadygold")
	self.alreadyjijia   = cc.uiloader:seekNodeByName(self, "alreadyjijia")

end

function LevelDetailLayer:initUI()
	-- init btn
	self:initBtns()

    --三个推荐
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

    --content
	local groupID = self.groupId
	local levelID = self.levelId
	local DataTable = self.DataTable

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

		local armature = ccs.Armature:create(DataTable["enemyPlay"])
		armature:setScale(0.8)
		addChildCenter(armature, self.panlEnemy)
		armature:getAnimation():play("stand" , -1, 1)

	end

	self:initMapUI()

	local weaponimg = display.newSprite("#icon_"..DataTable["weapon"]..".png")
	weaponimg:setScale(0.4)
	local bibeiimg = cc.uiloader:seekNodeByName(self, "bibeiimg")
	addChildCenter(weaponimg, bibeiimg) 

end

function LevelDetailLayer:initMapUI()
    cc.FileUtils:getInstance():addSearchPath("res/Fight/Maps")

	local mapSrcName = "map_"..self.groupId.."_"..self.levelId..".json"   -- todo 外界

	local map = cc.uiloader:load(mapSrcName)
	map:setScale(0.47, 0.48)

	local mapNode = cc.uiloader:seekNodeByName(self, "mapimage")
	mapNode:addChild(map)


	--clear
	local index = 1
    while true do
    	local name = "place_" .. index
    	local placeNode = cc.uiloader:seekNodeByName(map, name)
    	local scaleNode = cc.uiloader:seekNodeByName(placeNode, "scale")
    	--clear scaleNode
    	if scaleNode then scaleNode:setVisible(false) end
        if placeNode == nil then
            break
        end

        --clear colorNode
    	local colorNode = cc.uiloader:seekNodeByName(placeNode, "color")
        colorNode:setVisible(false)

        index = index + 1
    end
end

function LevelDetailLayer:initBtns()
	self.btnOff   = cc.uiloader:seekNodeByName(self, "btn_off")
	self.btnStart = cc.uiloader:seekNodeByName(self, "btn_start")
	self.btnBibei = cc.uiloader:seekNodeByName(self, "btn_bibei")
	self.btnGold  = cc.uiloader:seekNodeByName(self, "btn_gold")
	self.btnJijia = cc.uiloader:seekNodeByName(self, "btn_jijia")

	-- set touch enable
	self.btnOff   :setTouchEnabled(true)
	self.btnStart :setTouchEnabled(true)
	self.btnBibei :setTouchEnabled(true)
	self.btnGold  :setTouchEnabled(true)
	self.btnJijia :setTouchEnabled(true)


	------ on btn clicked
	--offbtn
	addBtnEventListener(self.btnOff, function(event)
        if event.name=='began' then
            -- print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnOff()
        end
    end)
    --startbtn
    addBtnEventListener(self.btnStart, function(event)
        if event.name=='began' then
            -- print("startbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnStart()
        end
    end)
    --bibei
    addBtnEventListener(self.btnBibei, function(event)
        if event.name=='began' then
            -- print("bibeibtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnBibei()
        end
    end)
    --gold
    addBtnEventListener(self.btnGold, function(event)
        if event.name=='began' then
            -- print("btngold is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnGold()
        end
    end)
    --jijia
    addBtnEventListener(self.btnJijia, function(event)
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
	print("self.groupId,", self.groupId)
	ui:changeLayer("FightPlayer", {groupId = self.groupId, 
		levelId = self.levelId})
	self:onClickBtnOff()
end

function LevelDetailLayer:onClickBtnBibei()
	print("bibeibtn is clicked!")
	self.alreadybibei:setVisible(true)
	self.btnBibei:setVisible(false)
end

function LevelDetailLayer:onClickBtnGold()
	print("goldbtn is clicked!")
	self.alreadygold:setVisible(true)
	self.btnGold:setVisible(false)
end

function LevelDetailLayer:onClickBtnJijia()
	print("jijiabtn is clicked!")
	self.alreadyjijia:setVisible(true)
	self.btnJijia:setVisible(false)
end

---- initData ----
function LevelDetailLayer:initData()
	local groupID = self.groupId
	local levelID = self.levelId
	self.DataTable = self.model:getConfig(groupID,levelID)
end

return LevelDetailLayer