
local LevelDetailLayer = class("LevelDetailLayer", function()
	return display.newLayer()
end)

function LevelDetailLayer:ctor(properties)
	--instance
	self.levelDetailModel = md:getInstance("LevelDetailModel")
	self.weaponListModel = md:getInstance("WeaponListModel")
	self.inlayModel 	 = md:getInstance("InlayModel")
	self.propModel       = md:getInstance("PropModel")
	self.guide           = md:getInstance("Guide")
	self.buyModel 		 = md:getInstance("BuyModel")
	self.groupId 		 = properties.groupId
	self.levelId 		 = properties.levelId
	self.levelInfo       = self.groupId.."_"..self.levelId

	--events
    cc.EventProxy.new(self.weaponListModel, self)
        :addEventListener(self.weaponListModel.WEAPON_UPDATE_EVENT , handler(self, self.refreshUI))
    cc.EventProxy.new(self.propModel, self)
        :addEventListener(self.propModel.PROP_UPDATE_EVENT 	   , handler(self, self.refreshUI))
    cc.EventProxy.new(self.inlayModel, self)
        :addEventListener(self.inlayModel.REFRESH_INLAY_EVENT      , handler(self, self.refreshUI))
	self:initData()
	
	--ui
	self:loadCCS()
	self:initUI()

    self:initGuide()

    self:refreshUI()
end

function LevelDetailLayer:loadCCS()
	-- load control bar
	cc.FileUtils:getInstance():addSearchPath("res/LevelDetail")
	local controlNode = cc.uiloader:load("guanqiakaishi.ExportJson")
    self:addChild(controlNode)

    --armature
	local manager = ccs.ArmatureDataManager:getInstance()
    local src = "res/LevelDetail/bt_kaishi/bt_kaishi.ExportJson"
    manager:addArmatureFileInfo(src) 
    local plist = "res/LevelDetail/bt_kaishi/bt_kaishi0.plist"
    local png   = "res/LevelDetail/bt_kaishi/bt_kaishi0.png"
    display.addSpriteFrames(plist, png)          

    --seek panels
	self.panelDetail  = cc.uiloader:seekNodeByName(self, "paneldetail")
	self.panelJijia  = cc.uiloader:seekNodeByName(self, "paneljijia")
	self.panelGoldWeapon  = cc.uiloader:seekNodeByName(self, "panelgoldweapon")
	self.panelRecommend  = cc.uiloader:seekNodeByName(self, "panelrecommend")
	self.panelDescribe = cc.uiloader:seekNodeByName(self.panelDetail, "paneldescribe")
	self.panelmap = cc.uiloader:seekNodeByName(self.panelDetail, "panelmap")

    -- seek btns
	self.btnOff   = cc.uiloader:seekNodeByName(self.panelDetail, "btn_off")
	self.btnStart = cc.uiloader:seekNodeByName(self.panelDetail, "btnbegin")
	self.btnBibei = cc.uiloader:seekNodeByName(self.panelRecommend, "btn_bibei")
	self.btnGold  = cc.uiloader:seekNodeByName(self.panelGoldWeapon, "btn_gold")
	self.btnJijia = cc.uiloader:seekNodeByName(self.panelJijia, "btn_jijia")

	-- seek label
	self.labelTitle    = cc.uiloader:seekNodeByName(self.panelDescribe, "label_title")
	self.labelId       = cc.uiloader:seekNodeByName(self.panelDescribe, "label_id")
	self.labelDesc     = cc.uiloader:seekNodeByName(self.panelDescribe, "label_desc")
	self.labelTasktype = cc.uiloader:seekNodeByName(self.panelDescribe, "label_tasktype")
	self.labelGet = cc.uiloader:seekNodeByName(self.panelDescribe, "levelget")
	self.panelBiaozhu = cc.uiloader:seekNodeByName(self.panelDescribe, "panelbiaozhu")
	self.target    = cc.uiloader:seekNodeByName(self.panelDescribe, "target")
	cc.uiloader:seekNodeByName(self.btnBibei, "yijiana")
		:enableOutline(cc.c4b(0, 0, 0,255), 2)
	cc.uiloader:seekNodeByName(self.btnGold, "yijianb")
		:enableOutline(cc.c4b(0, 0, 0,255), 2)
	cc.uiloader:seekNodeByName(self.btnJijia, "yijianc")
		:enableOutline(cc.c4b(0, 0, 0,255), 2)

	self.labelTitle:enableOutline(cc.c4b(0, 0, 0,255), 2)
	self.labelId:enableOutline(cc.c4b(0, 0, 0,255), 2)
	self.target:enableOutline(cc.c4b(0, 0, 0,255), 2)
	
	-- seek layer for image
	self.layerMap   = cc.uiloader:seekNodeByName(self.panelmap, "mapimage")
	self.layerBibei = cc.uiloader:seekNodeByName(self.panelRecommend, "bibeiimg")    
	self.layerEnemy = cc.uiloader:seekNodeByName(self.panelmap, "panlenemy")   

	-- seek already image
	self.alreadyBibei   = cc.uiloader:seekNodeByName(self.panelRecommend, "alreadybibei")
	self.alreadyGold   = cc.uiloader:seekNodeByName(self.panelGoldWeapon, "alreadygold")
	self.alreadyJijia   = cc.uiloader:seekNodeByName(self.panelJijia, "alreadyjijia")
end

function LevelDetailLayer:initUI()
    --推荐
	cc.uiloader:seekNodeByName(self.panelJijia, "dansedijj"):setColor(cc.c3b(249,0,255))
	cc.uiloader:seekNodeByName(self.panelGoldWeapon, "dansedihw"):setColor(cc.c3b(255,208,0))
	cc.uiloader:seekNodeByName(self.panelRecommend, "danseditj"):setColor(cc.c3b(0,255,198))

    --content
	self.labelTitle:setString(self.config["name"])
	self.labelId:setString(self.config["groupId"].."-"..self.config["levelId"])
	self.target:setString(self.config["taskDesc"])
	self.labelDesc:setString(self.config["desc"])
	self.labelTasktype:setString(self.config["taskTypeDesc"])
	self.labelGet:setVisible(false)
	self.panelBiaozhu:setVisible(false)
	local isWeaponAlreadyTogether = self.weaponListModel:isWeaponExist(self.config["suipianid"])
	if self.config["type"] == "boss" and isWeaponAlreadyTogether == false then
		self.labelGet:setVisible(true)
		self.panelBiaozhu:setVisible(true)
		local needWeaponNum = self.levelDetailModel:getNeedSuipianNum(self.config["suipianid"])
		local alreadyGetNum = self.levelDetailModel:getSuiPianNum(self.config["suipianid"])
		local suipianName = self.weaponListModel:getWeaponNameByID(self.config["suipianid"])
		self.labelGet:setString("本关卡可获得"..suipianName
					.."零件1个，当前"..alreadyGetNum.."/"..needWeaponNum)
	end
	if self.config["type"] == "boss" then
		local enemyPlay = self.config["enemyPlay"]
		local manager = ccs.ArmatureDataManager:getInstance()
        local src = "res/Fight/enemys/"..enemyPlay.."/"..enemyPlay..".ExportJson"
        manager:addArmatureFileInfo(src) 
        local plist = "res/Fight/enemys/"..enemyPlay.."/"..enemyPlay.."0.plist"
        local png   = "res/Fight/enemys/"..enemyPlay.."/"..enemyPlay.."0.png"
        display.addSpriteFrames(plist, png)          

		local armature = ccs.Armature:create(enemyPlay)
		armature:setScale(self.config["scale"])
		addChildCenter(armature, self.layerEnemy)
		armature:getAnimation():play("stand" , -1, 1)
	end

	self:initMapUI(self.config["mapImg"])
	self.recomWeaponId = self.config["weapon"]
	local recomWeapon = self.weaponListModel:getWeaponRecord(self.recomWeaponId)
	local weaponimg = display.newSprite("#icon_"..recomWeapon["imgName"]..".png")
	weaponimg:setScale(0.57)
	local bibeiimg = cc.uiloader:seekNodeByName(self.panelRecommend, "bibeiimg")
	addChildCenter(weaponimg, bibeiimg) 

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
end

function LevelDetailLayer:initBtns()
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
    local kaishiarmature = ccs.Armature:create("bt_kaishi")
    addChildCenter(goldarmature, self.btnGold)
    addChildCenter(jijiaarmature, self.btnJijia)
    addChildCenter(bibeiarmature, self.btnBibei)
    kaishiarmature:setPosition(116, 45)
    self.btnStart:addChild(kaishiarmature)
    goldarmature:getAnimation():play("yjzb" , -1, 1)
    jijiaarmature:getAnimation():play("yjzb" , -1, 1)
    bibeiarmature:getAnimation():play("yjzb" , -1, 1)
    kaishiarmature:getAnimation():play("Animation1" , -1, 1)

    --addEvents
	addBtnEventListener(self.btnOff, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnOff()
        end
    end)
    addBtnEventListener(self.btnStart, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnStart()
        end
    end)
    addBtnEventListener(self.btnBibei, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnBibei()
        end
    end)
    addBtnEventListener(self.btnGold, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnGold()
        end
    end)
    addBtnEventListener(self.btnJijia, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnJijia()
        end
    end)
end

function LevelDetailLayer:startGame()
	local fightData = {
		groupId = self.groupId, 
		levelId = self.levelId,
	}
	ui:changeLayer("FightPlayer", {fightData = fightData})
	self:onClickBtnOff()
end

function LevelDetailLayer:onClickBtnOff()
    ui:closePopup("LevelDetailLayer")
end

function LevelDetailLayer:onClickBtnStart()
	local data = getUserData()
	local userModel = md:getInstance("UserModel")
    local isDone = userModel:getUserLevel() >= 5
	if table.nums(data.inlay.inlayed) ~= 0 then
		self:startGame()
	elseif isDone and table.nums(data.inlay.inlayed) == 0 then
		ui:showPopup("commonPopup",
			 {type = "style5",
			 callfuncQuickInlay = handler(self,self.onClickQuickInlay),
			 callfuncGoldWeapon = handler(self,self.onClickGoldWeapon),
			 callfuncClose = handler(self,self.onClickCloseInlayNoti)})
	else
		self:startGame()
	end
end

function LevelDetailLayer:onClickCloseInlayNoti()
	self:startGame()
	local umData = {}
	umData[self.levelInfo] = "关闭镶嵌提示进战斗"
	um:event("关卡提示未镶嵌", umData)   
end

function LevelDetailLayer:onClickQuickInlay()
	self.inlayModel:equipAllInlays()
	self:startGame() 

	local umData = {}
	umData[self.levelInfo] = "点击快速镶嵌"
	um:event("关卡提示未镶嵌", umData)   
end

function LevelDetailLayer:onClickGoldWeapon()
	function confirmPopGoldGift()
		self:equipGold()
		self:startGame()
	end

	local goldweaponNum = self.inlayModel:getGoldWeaponNum()
	if goldweaponNum > 0 then
        self.inlayModel:equipAllInlays()
        self:startGame()	
	else
	    --buy
	    ui:showPopup("StoneBuyPopup",
	         {name = "黄金武器x2", 
	         price = 40,
	         onClickConfirm = handler(self, self.buyGoldByStone)},
	         {animName = "moveDown", opacity = 150})

	    local umData = {}
		umData[self.levelInfo] = "点击黄金武器"
		um:event("关卡提示未镶嵌", umData)
    end
end

function LevelDetailLayer:onClickBtnBibei()
	if self.weaponListModel:isWeaponExist(self.recomWeaponId) then
		if self.config["type"] == "juji" then

		else
			self.weaponListModel:equipBag(self.recomWeaponId, 1)
		end
	else
		-- 保留，暂时不用
        -- self.buyModel:showBuy("weaponGiftBag",{ payDoneFunc = handler(self, self.onBuyWeaponGiftSucc),
        -- deneyBuyFunc = handler(self,self.onCancelWeaponGift),isNotPopKefu = true}, 
        -- 	"关卡详情_点击必备按钮")
		self:onCancelWeaponGift()
	end
end

function LevelDetailLayer:onClickBtnJijia()
	-- 保留，暂时不用
	-- function deneyGoldGiftJijia()
	    -- self.buyModel:showBuy("armedMecha",{}, 
	    -- 	"关卡详情_点击机甲按钮")
	-- end
 --    self.buyModel:showBuy("goldGiftBag",{deneyBuyFunc = deneyGoldGiftJijia},
 --     	"关卡详情_点击机甲按钮")

    --buy
    ui:showPopup("StoneBuyPopup",
         {name = "无敌机甲x2", 
         price = 40,
         onClickConfirm = handler(self, self.buyRobotByStone)},
         {animName = "moveDown", opacity = 150})

end

function LevelDetailLayer:buyRobotByStone()
	print("function FightProp:buyRobotByStone()")	
	local kValue = 40
	local user = md:getInstance("UserModel")
    local isAfforded = user:costDiamond(kValue, true, "关卡详情界面_无敌机甲x2") 
    if isAfforded then
    	local propModel = md:getInstance("PropModel")
    	propModel:addProp("jijia", 2)
        ui:closePopup("StoneBuyPopup")
    end		
end

function LevelDetailLayer:equipGold()
	self.inlayModel:equipAllInlays()
end

function LevelDetailLayer:onClickBtnGold()
	function deneyGoldGift()
	    self.buyModel:showBuy("goldWeapon",{payDoneFunc = handler(self, self.equipGold)}, "关卡详情_黄武按钮取消土豪礼包")
	end

	local goldweaponNum = self.inlayModel:getGoldWeaponNum()
	if goldweaponNum > 0 then
        self.inlayModel:equipAllInlays()	
        return 
    end

    --buy
    ui:showPopup("StoneBuyPopup",
         {name = "黄金武器x2", 
         price = 40,
         onClickConfirm = handler(self, self.buyGoldByStone)},
         {animName = "moveDown", opacity = 150})

end

function LevelDetailLayer:buyGoldByStone()
	print("function LevelDetailLayer:buyGoldByStone()")	
	local kValue = 40
	local user = md:getInstance("UserModel")
    local isAfforded = user:costDiamond(kValue, true, "关卡详情界面_黄金武器x2") 
    if isAfforded then
    	local inlayModel = md:getInstance("InlayModel")
    	inlayModel:buyGoldsInlay(2)
        ui:closePopup("StoneBuyPopup")
    end		
end

function LevelDetailLayer:onCancelWeaponGift()
	self:buyWeaponByStone()
end

function LevelDetailLayer:buyWeaponByStone()
	local weaponRecord = self.weaponListModel:getWeaponRecord(self.recomWeaponId)
	local cost = weaponRecord["cost"]
	local weaponName = self.weaponListModel:getWeaponNameByID(self.recomWeaponId)	
	local strPos  =  "关卡详情_点击解锁武器" .. weaponName
	
	--costDiamond
	local user = md:getInstance("UserModel")
    local isAfforded = user:costDiamond(cost, true, strPos) 
    if isAfforded then
        self.weaponListModel:buyWeapon(self.recomWeaponId)
        ui:showPopup("WeaponNotifyLayer",
         {type = "gun",weaponId = self.recomWeaponId},{opacity = 255})
        return true
    else
        return false
    end
end

---- initData ----
function LevelDetailLayer:initData()
	local groupId = self.groupId
	local levelId = self.levelId
	self.config = self.levelDetailModel:getConfig(groupId,levelId)
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

function LevelDetailLayer:refreshUI(event)
	if self.weaponListModel:isRecomWeaponed(self.recomWeaponId) then
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