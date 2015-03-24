import("..includes.functionUtils")

local LevelDetailLayer = class("LevelDetailLayer", function()
	return display.newLayer()
end)

function LevelDetailLayer:ctor(properties)
	--instance
	self.levelDetailModel = md:getInstance("LevelDetailModel")
	self.weaponListModel = md:getInstance("WeaponListModel")
	self.inlayModel 	 = md:getInstance("InlayModel")
	self.propModel       = md:getInstance("propModel")
	self.guide           = md:getInstance("Guide")
	self.buyModel = md:getInstance("BuyModel")
	self.groupId = properties.groupId
	self.levelId = properties.levelId
	self:initData()
	
	--ui
	self:loadCCS()
	self:initUI()

    self:initGuide()
end

function LevelDetailLayer:loadCCS()
	-- load control bar
	cc.FileUtils:getInstance():addSearchPath("res/LevelDetail")
	local controlNode = cc.uiloader:load("guanqiakaishi.ExportJson")
    self:addChild(controlNode)

	-- seek label
	self.labelTitle    = cc.uiloader:seekNodeByName(self, "label_title")
	self.labelId       = cc.uiloader:seekNodeByName(self, "label_id")
	self.labelDesc     = cc.uiloader:seekNodeByName(self, "label_desc")
	self.labelTasktype = cc.uiloader:seekNodeByName(self, "label_tasktype")
	self.labelGet = cc.uiloader:seekNodeByName(self, "levelget")
	self.panelBiaozhu = cc.uiloader:seekNodeByName(self, "panelbiaozhu")
	self.target    = cc.uiloader:seekNodeByName(self, "target")
	cc.uiloader:seekNodeByName(self, "yijiana")
		:enableOutline(cc.c4b(0, 0, 0,255), 2)
	cc.uiloader:seekNodeByName(self, "yijianb")
		:enableOutline(cc.c4b(0, 0, 0,255), 2)
	cc.uiloader:seekNodeByName(self, "yijianc")
		:enableOutline(cc.c4b(0, 0, 0,255), 2)
	self.startlabel    = cc.uiloader:seekNodeByName(self, "startlabel")

	self.labelTitle:enableOutline(cc.c4b(0, 0, 0,255), 2)
	self.labelId:enableOutline(cc.c4b(0, 0, 0,255), 2)
	self.target:enableOutline(cc.c4b(0, 0, 0,255), 2)
	self.startlabel:enableOutline(cc.c4b(255, 255, 255,255), 2)
	
	-- seek layer for image
	self.layerMap   = cc.uiloader:seekNodeByName(self, "mapimage")
	self.layerBibei = cc.uiloader:seekNodeByName(self, "bibeiimg")    
	self.layerEnemy = cc.uiloader:seekNodeByName(self, "panlenemy")   

	-- seek already image
	self.alreadyBibei   = cc.uiloader:seekNodeByName(self, "alreadybibei")
	self.alreadyGold   = cc.uiloader:seekNodeByName(self, "alreadygold")
	self.alreadyJijia   = cc.uiloader:seekNodeByName(self, "alreadyjijia")

    -- anim
    local src = "res/LevelDetail/btequipanim/bt_yjzb.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    local plist = "res/LevelDetail/btequipanim/bt_yjzb0.plist"
    local png = "res/LevelDetail/btequipanim/bt_yjzb0.png"
    display.addSpriteFrames(plist,png)

end

function LevelDetailLayer:initUI()
	
    --三个推荐
	local dansedijj = cc.uiloader:seekNodeByName(self, "dansedijj")
	local dansejj = cc.uiloader:seekNodeByName(self, "dansejj")	
	local dansedihw = cc.uiloader:seekNodeByName(self, "dansedihw")
	local dansehw = cc.uiloader:seekNodeByName(self, "dansehw")
	local danseditj = cc.uiloader:seekNodeByName(self, "danseditj")
	local dansetj = cc.uiloader:seekNodeByName(self, "dansetj")
	dansedijj:setColor(cc.c3b(249,0,255))
	dansedihw:setColor(cc.c3b(255,208,0))
	danseditj:setColor(cc.c3b(0,255,198))

    --content
	local DataTable = self.DataTable

	self.labelTitle:setString(DataTable["name"])
	self.labelId:setString(DataTable["groupId"].."-"..DataTable["levelId"])
	self.target:setString(DataTable["taskDesc"])
	self.labelDesc:setString(DataTable["desc"])
	self.labelTasktype:setString(DataTable["taskTypeDesc"])
	self.labelGet:setVisible(false)
	self.panelBiaozhu:setVisible(false)
	local isWeaponAlreadyTogether = self.weaponListModel:isWeaponExist(DataTable["suipianid"])
	if DataTable["type"] == "boss" and isWeaponAlreadyTogether == false then
		self.labelGet:setVisible(true)
		self.panelBiaozhu:setVisible(true)
		local needWeaponNum = self.levelDetailModel:getNeedSuipianNum(DataTable["suipianid"])
		local alreadyGetNum = self.levelDetailModel:getSuiPianNum(DataTable["suipianid"])
		local suipianName = self.weaponListModel:getWeaponNameByID(DataTable["suipianid"])
		self.labelGet:setString("本关卡可获得"..suipianName
					.."零件1个，当前"..alreadyGetNum.."/"..needWeaponNum)
	end
	if DataTable["type"] == "boss" then
		local enemyPlay = DataTable["enemyPlay"]
		dump(enemyPlay)
		local manager = ccs.ArmatureDataManager:getInstance()
        local src = "res/Fight/enemys/"..enemyPlay.."/"..enemyPlay..".ExportJson"
        manager:addArmatureFileInfo(src) 
        local plist = "res/Fight/enemys/"..enemyPlay.."/"..enemyPlay.."0.plist"
        local png   = "res/Fight/enemys/"..enemyPlay.."/"..enemyPlay.."0.png"
        display.addSpriteFrames(plist, png)          

		local armature = ccs.Armature:create(enemyPlay)
		armature:setScale(DataTable["scale"])
		addChildCenter(armature, self.layerEnemy)
		armature:getAnimation():play("stand" , -1, 1)
	end

	self:initMapUI(DataTable["mapImg"])
	self.recomWeaponId = DataTable["weapon"]
	local recomWeapon = self.weaponListModel:getWeaponRecord(self.recomWeaponId)
	local weaponimg = display.newSprite("#icon_"..recomWeapon["imgName"]..".png")
	weaponimg:setScale(0.4)
	local bibeiimg = cc.uiloader:seekNodeByName(self, "bibeiimg")
	addChildCenter(weaponimg, bibeiimg) 

	-- init btn
	self:initBtns()
end

function LevelDetailLayer:initMapUI(mapName)
    cc.FileUtils:getInstance():addSearchPath("res/Fight/Maps")

	local mapSrcName = mapName..".jpg"   -- todo 外界
	local mapimg = cc.ui.UIImage.new(mapSrcName)

	local mapNode = cc.uiloader:seekNodeByName(self, "mapimage")
	local mapPanlSize = mapNode:getContentSize()
	local mapImgSize = mapimg:getBoundingBox()
	mapimg:setScale(mapPanlSize.width/mapImgSize.width,mapPanlSize.height/mapImgSize.height)
	-- map:setAnchorPoint(0.5,0.5)
	addChildCenter(mapimg, mapNode)

	--clear
	local index = 1
    while true do
    	local name = "place" .. index
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
	self.btnStart = cc.uiloader:seekNodeByName(self, "btnbegin")
	self.btnBibei = cc.uiloader:seekNodeByName(self, "btn_bibei")
	self.btnGold  = cc.uiloader:seekNodeByName(self, "btn_gold")
	self.btnJijia = cc.uiloader:seekNodeByName(self, "btn_jijia")

	-- set touch enable
	self.btnOff   :setTouchEnabled(true)
	self.btnStart :setTouchEnabled(true)
	self.btnBibei :setTouchEnabled(true)
	self.btnGold  :setTouchEnabled(true)
	self.btnJijia :setTouchEnabled(true)

    --anim
    local goldarmature = ccs.Armature:create("bt_yjzb")
    local jijiaarmature = ccs.Armature:create("bt_yjzb")
    local bibeiarmature = ccs.Armature:create("bt_yjzb")
    addChildCenter(goldarmature, self.btnGold)
    addChildCenter(jijiaarmature, self.btnJijia)
    addChildCenter(bibeiarmature, self.btnBibei)
    goldarmature:getAnimation():play("yjzb" , -1, 1)
    jijiaarmature:getAnimation():play("yjzb" , -1, 1)
    bibeiarmature:getAnimation():play("yjzb" , -1, 1)

	-- if self.weaponListModel:isRecomWeaponed(self.recomWeaponId ) then
	-- 	self.alreadyBibei:setVisible(true)
	-- 	self.btnBibei:setVisible(false)
	-- end
	-- if self.inlayModel:isGetAllGold() then
	-- 	self.alreadyGold:setVisible(true)
	-- 	self.btnGold:setVisible(false)
	-- end
	-- if self.propModel:getPropNum("jijia") > 0 then
	-- 	self.alreadyJijia:setVisible(true)
	-- 	self.btnJijia:setVisible(false)
	-- end
	self:refreshBtns()
	------ on btn clicked
	--offbtn
	addBtnEventListener(self.btnOff, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnOff()
        end
    end)
    --startbtn
    addBtnEventListener(self.btnStart, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnStart()
        end
    end)
    --bibei
    addBtnEventListener(self.btnBibei, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnBibei()
        end
    end)
    --gold
    addBtnEventListener(self.btnGold, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnGold()
        end
    end)
    --jijia
    addBtnEventListener(self.btnJijia, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnJijia()
        end
    end)
end

function LevelDetailLayer:startGame()
	self.levelDetailModel:setCurGroupAndLevel(self.groupId,self.levelId)
	ui:changeLayer("FightPlayer", {groupId = self.groupId, 
		levelId = self.levelId})
	self:onClickBtnOff()
end

function LevelDetailLayer:onClickBtnOff()
    ui:closePopup("LevelDetailLayer")
end

function LevelDetailLayer:onClickBtnStart()
	self:startGame()
end

function LevelDetailLayer:onClickBtnBibei()
	if self.weaponListModel:isWeaponExist(self.recomWeaponId) then
		if self.DataTable["type"] == "juji" then
		else
			self.weaponListModel:equipBag(self.recomWeaponId,1)
		end
		-- self.alreadyBibei:setVisible(true)
		-- self.btnBibei:setVisible(false)
			self:refreshBtns()

	else
        self.buyModel:showBuy("weaponGiftBag",{payDoneFunc = handler(self, self.onBuyWeaponGiftSucc),
        deneyBuyFunc = handler(self,self.onCancelWeaponGift)}, 
        	"关卡详情_点击必备按钮")
	end
		self:refreshBtns()

end

function LevelDetailLayer:onClickBtnJijia()
	function equipJijia()
		-- self.alreadyJijia:setVisible(true)
		-- self.btnJijia:setVisible(false)	
			self:refreshBtns()

	end

	function deneyGoldGiftJijia()
	    self.buyModel:showBuy("armedMecha",{payDoneFunc = equipJijia}, "关卡详情_点击机甲按钮")
	end
	    self.buyModel:showBuy("goldGiftBag",{payDoneFunc = equipJijia,deneyBuyFunc = deneyGoldGiftJijia},
	     "关卡详情_点击机甲按钮")
end

function LevelDetailLayer:onClickBtnGold()
	function equipGold()
		self.inlayModel:equipAllInlays(true)
		-- self.alreadyGold:setVisible(true)
		-- self.btnGold:setVisible(false)
			self:refreshBtns()
	
	end
	
	function deneyGoldGift()
	    self.buyModel:showBuy("goldWeapon",{payDoneFunc = equipGold}, "关卡详情_黄武按钮取消土豪礼包")
	end

	local goldweaponNum = self.inlayModel:getGoldWeaponNum()
	local isDone = self.guide:isDone("weapon")
	if goldweaponNum > 0 then
        self.inlayModel:equipAllInlays()
		-- self.alreadyGold:setVisible(true)
		-- self.btnGold:setVisible(false)	
			self:refreshBtns()

    else
	    self.buyModel:showBuy("goldGiftBag",{payDoneFunc = equipGold,deneyBuyFunc = deneyGoldGift},
	     "关卡详情_点击黄武按钮")
	end
end

function LevelDetailLayer:onCancelWeaponGift()
	local weaponRecord = self.weaponListModel:getWeaponRecord(self.recomWeaponId)
	local rmbCost = weaponRecord["rmbCost"]
    if  rmbCost == 6 then
        self.buyModel:showBuy("unlockWeapon",{payDoneFunc = handler(self, self.onBuyWeaponSucc),weaponid = self.recomWeaponId}, "关卡详情_点击解锁"..self.recomWeaponId)
    elseif rmbCost == 10 then
        self.buyModel:showBuy("highgradeWeapon",{weaponid = self.recomWeaponId}, "关卡详情_点击解锁高级武器"..self.recomWeaponId)
    end
end

function LevelDetailLayer:onBuyWeaponGiftSucc()
    local levelMapModel = md:getInstance("LevelMapModel")
    levelMapModel:hideGiftBagIcon()
	self.weaponListModel:equipBag(self.recomWeaponId,1)
	-- self.alreadyBibei:setVisible(true)
	-- self.btnBibei:setVisible(false)
		self:refreshBtns()

end

function LevelDetailLayer:onBuyWeaponSucc()
	self.levelDetailModel:reloadlistview()
	self.weaponListModel:equipBag(self.recomWeaponId,1)
	-- self.alreadyBibei:setVisible(true)
	-- self.btnBibei:setVisible(false)
		self:refreshBtns()

end


---- initData ----
function LevelDetailLayer:initData()
	local groupId = self.groupId
	local levelId = self.levelId
	self.DataTable = self.levelDetailModel:getConfig(groupId,levelId)
end

function LevelDetailLayer:initGuide()
	local guide = md:getInstance("Guide")
    local isDone = guide:isDone("weapon")
    if isDone then return end
    --点击进入战斗
    guide:addClickListener({
        id = "weapon_enter",
        groupId = "weapon",
        rect = self.btnStart:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
            self:onClickBtnStart()
        end
     })     
end

function LevelDetailLayer:refreshBtns()
	if self.weaponListModel:isRecomWeaponed(self.recomWeaponId ) then
		self.alreadyBibei:setVisible(true)
		self.btnBibei:setVisible(false)
	end
	if self.inlayModel:isGetAllGold() then
		self.alreadyGold:setVisible(true)
		self.btnGold:setVisible(false)
	end
	if self.propModel:getPropNum("jijia") > 0 then
		self.alreadyJijia:setVisible(true)
		self.btnJijia:setVisible(false)
	end
end

return LevelDetailLayer