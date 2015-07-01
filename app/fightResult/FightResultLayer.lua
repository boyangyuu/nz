local FightResultLayer = class("FightResultLayer", function()
	return display.newLayer()
end)

function FightResultLayer:ctor()
    local fightFactory    =  md:getInstance("FightFactory")
    local fightModel 	  = fightFactory:getFight()
    self.fightData        = fightModel:getResultData()
    assert(self.fightData["fightType"] == "levelFight")
	self.weaponListModel  = md:getInstance("WeaponListModel")
	self.guide      	  = md:getInstance("Guide")
	self.levelDetailModel = md:getInstance("LevelDetailModel")
	self.fightResultModel = md:getInstance("FightResultModel")
    self.inlayModel 	  = md:getInstance("InlayModel")
    self.userModel        = md:getInstance("UserModel")
    self.levelMapModel    = md:getInstance("LevelMapModel")

	self.cardover = {}
    self.cardgold = {}
    self.cardsilver = {}
	self.cardbronze = {}
    self.cardtouch = {}
    self.cardicon = {}
    self.cardlabel = {}
    self.card = {}
    self.star = {}
    self.lock = {}
    self.giveTable = {}
    self.lockTable = {}

    self.itemsTable = {}
 
    self.userModel:addMoney(self.fightData["goldNum"])
    um:bonusVirtualCurrency(self.fightData["goldNum"], 4)
    local hpPercent = self.fightData["hpPercent"]
    self.grade = self.fightResultModel:getGrade(hpPercent)

	self:onSentAward()
	self:loadCCS()
	self:initUI()
	self:initUIContent()
	self:playSound()

	self:playStar(self.grade)
    self:setNodeEventEnabled(true)

	self:initGuide()
	self:initGuide3()
end

function FightResultLayer:playSound()
    local rwwc   = "res/Music/ui/rwwc.wav"
    audio.playSound(rwwc,false)
end

function FightResultLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/FightResult")
	local controlNode = cc.uiloader:load("guanqiapingjia.ExportJson")
    self:addChild(controlNode)

    --anim
    local starsrc = "res/FightResult/anim/gkjs_xing/gkjs_xing.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(starsrc)
    local plist = "res/FightResult/anim/gkjs_xing/gkjs_xing0.plist"
    local png = "res/FightResult/anim/gkjs_xing/gkjs_xing0.png"
    display.addSpriteFrames(plist,png)

    local ksxqsrc = "res/LevelDetail/bt_ksxq/bt_ksxq.ExportJson"
    manager:addArmatureFileInfo(ksxqsrc)
    local plist = "res/LevelDetail/bt_ksxq/bt_ksxq0.plist"
    local png   = "res/LevelDetail/bt_ksxq/bt_ksxq0.png"
    display.addSpriteFrames(plist, png)          

end

function FightResultLayer:playStar(numStar)
	local posXinterval = 112
	for i=1,numStar do
		local delay = i * 0.5
		local function starCall()
		    local starArmature = ccs.Armature:create("gkjs_xing")
		    starArmature:setPosition(43.5,42)
		    self.star[i]:addChild(starArmature)
		    if i == numStar then
		    	starArmature:getAnimation():setMovementEventCallFunc(
		    		function(armatureBack,movementType,movementId ) 
	                if movementType == ccs.MovementEventType.complete then
		         		self:playCard()
		         		self:performWithDelay(showButton, 1)
		         	end    
	            end)
		    end
			starArmature:getAnimation():play("gkjs_xing" , -1, 0)
		    local zx = "res/Music/ui/zx.wav"
		    audio.playSound(zx,false)
		end
		self:performWithDelay(starCall, delay)
	end
end


function FightResultLayer:initUI()
    for i=1,5 do
    	self.star[i] = cc.uiloader:seekNodeByName(self, "panelstar"..i)
	end
    for i=1,6 do
    	self.cardgold[i]   = cc.uiloader:seekNodeByName(self, "cardgold"..i)
    	self.cardsilver[i] = cc.uiloader:seekNodeByName(self, "cardsilver"..i)
    	self.cardbronze[i] = cc.uiloader:seekNodeByName(self, "cardbronze"..i)
    	self.cardover[i]   = cc.uiloader:seekNodeByName(self, "cardover"..i)
    	self.cardicon[i]   = cc.uiloader:seekNodeByName(self, "icon"..i)
    	self.cardlabel[i]  = cc.uiloader:seekNodeByName(self, "labelcard"..i)
    	self.card[i]       = cc.uiloader:seekNodeByName(self, "card"..i)
    	self.lock[i]       = cc.uiloader:seekNodeByName(self, "suo"..i)
    	self.cardover[i]:setScaleX(0)
    end

    self.btnInlay      = cc.uiloader:seekNodeByName(self, "btninlay")
    self.btnGetAll     = cc.uiloader:seekNodeByName(self, "btngetall")
    self.alreadyInlay  = cc.uiloader:seekNodeByName(self, "alreadyinlay")
    self.alreadyGetAll = cc.uiloader:seekNodeByName(self, "alreadygetall")
    self.panlgetall    = cc.uiloader:seekNodeByName(self, "panlgetall")
    self.btnback       = cc.uiloader:seekNodeByName(self, "btnnext")
	self.alreadyInlay:setVisible(false)
	self.alreadyGetAll:setVisible(false)
	self.btnInlay:setOpacity(0)
	self.btnGetAll:setOpacity(0)
	self.btnInlay:setButtonEnabled(false)
	self.btnGetAll:setButtonEnabled(false)
	self.btnback:setButtonEnabled(false)

    self.inlayArmature = ccs.Armature:create("bt_ksxq")
    self.getallArmature = ccs.Armature:create("bt_ksxq")
    self.btnInlay:addChild(self.inlayArmature)
    self.btnGetAll:addChild(self.getallArmature)
    self.inlayArmature:getAnimation():play("yjzb" , -1, 1)
    self.getallArmature:getAnimation():play("yjzb" , -1, 1)

    labelMoney = cc.uiloader:seekNodeByName(self, "labelMoney")
    labelDiamond = cc.uiloader:seekNodeByName(self, "labelDiamond")
    labelMoney:setColor(cc.c3b(255, 205, 0))
    labelDiamond:setColor(cc.c3b(255, 205, 0))
    labelMoney:enableOutline(cc.c4b(0, 0, 0,255), 2)
    labelDiamond:enableOutline(cc.c4b(0, 0, 0,255), 2)
    labelMoney:setString("本关战斗获得"..self.fightData["goldNum"].."金币")
    if self.fightData["isFirstWin"] then

    	--award
    	local gId = self.fightData["groupId"]
    	local lId = self.fightData["levelId"]
    	self:popOpenModeNoti(gId,lId)
    	local record = self.levelDetailModel:getConfig(gId,lId)
		labelDiamond:setString("首次战斗获得"..record["giftDiamond"].."宝石")
		self.userModel:addDiamond(record["giftDiamond"])

		--save data
	    local fightFactory    =  md:getInstance("FightFactory")
	    local fightModel 	  = fightFactory:getFight()
	    fightModel:saveFightedLevelData("awarded")
	end

	function showButton()
		self:startGuide()

		self.btnGetAll:setButtonEnabled(true)
		self.btnInlay:setButtonEnabled(true)
		self.btnGetAll:runAction(cc.FadeIn:create(0.3))
		self.btnInlay:runAction(cc.FadeIn:create(0.3))

		if table.nums(self.lockTable) == 0 then
			self.btnGetAll:setButtonEnabled(false)
			self.alreadyGetAll:setVisible(true)
			self.alreadyGetAll:setScale(5)
			transition.execute(self.alreadyGetAll, cc.ScaleTo:create(0.2, 1), {
					    easing = "Out",
					})
			if self.getallArmature then
				self.getallArmature:removeFromParent()
				self.getallArmature = nil
			end
		end
		self.btnback:setButtonEnabled(true)


	    local curGroup, curLevel = self.fightData["groupId"], self.fightData["levelId"]
		local levelInfo = curGroup.."_"..curLevel
		local umData = {}
	    umData[levelInfo] = "快速镶嵌展示"
	    um:event("关卡结算_快速镶嵌", umData)

	end

    addBtnEventListener(self.btnInlay, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
	        ui:showPopup("commonPopup",
				 {type = "style2", content = "镶嵌成功",delay = 0.5},
				 {opacity = 155})				
        	self:quickInlay()
	        self.btnInlay:setButtonEnabled(false)
			self.alreadyInlay:setVisible(true)
			self.alreadyInlay:setScale(5)
			transition.execute(self.alreadyInlay, cc.ScaleTo:create(0.2, 1), {
					    easing = "Out",
					})
			if self.inlayArmature then
				self.inlayArmature:removeFromParent()
				self.inlayArmature = nil
			end
        end
    end)

    addBtnEventListener(self.btnGetAll, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
	        ui:showPopup("commonPopup",
				 {type = "style1", content = "是否花费10颗宝石翻开剩余卡牌",
				 callfuncCofirm =  handler(self, self.onCofirmLeftCard)},
				 {opacity = 155})
        end
    end)
	addBtnEventListener(self.btnback, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then		
        	self:onClickBtnNext()
        end
    end)
end

function FightResultLayer:popOpenModeNoti(groupId,levelId)
    if groupId == 1 and levelId == 5 then
    	ui:showPopup("commonPopup",
         {type = "style1", content = "恭喜您开启无尽狙击模式，会获得丰富奖励，快去尝试吧！"},
         {opacity = 0})
    end
    if groupId == 1 and levelId == 7 then
    	ui:showPopup("commonPopup",
         {type = "style1", content = "恭喜您开启BOSS竞技场！"},
         {opacity = 0})
    end
end

function FightResultLayer:onClickBtnNext()
	 ui:changeLayer("HomeBarLayer",{fightData = self.fightData})
end

function FightResultLayer:initUIContent()
    for k,v in pairs(self.itemsTable) do
    	if v["falltype"] == "gun" then
    		local record = self.weaponListModel:getWeaponRecord(v["id"])
			self.cardlabel[k]:setString(record["name"])
			local icon = display.newSprite("#icon_"..record["imgName"]..".png")
			icon:setScale(0.39)
			icon:setRotation(39)
			addChildCenter(icon, self.cardicon[k])
    	elseif v["falltype"] == "inlay" then
    		local record = self.fightResultModel:getInlayrecordByID(v["id"])
    		local property = self.inlayModel:getInlayProperty(v["id"])
			if property ~= 4 then
				self.cardlabel[k]:setString(record["describe2"].."X2")
			else
				self.cardlabel[k]:setString(record["describe2"])
			end
			local icon = display.newSprite("#"..record["imgname"]..".png")
			icon:setScale(1.33)
			addChildCenter(icon, self.cardicon[k])
			if record["property"] == 2 then
				self.cardgold[k]:setVisible(false)
				self.cardsilver[k]:setVisible(false)
			elseif record["property"] == 3 then
				self.cardgold[k]:setVisible(false)
				self.cardbronze[k]:setVisible(false)
			elseif record["property"] == 4 then
				self.cardsilver[k]:setVisible(false)
				self.cardbronze[k]:setVisible(false)
			end
    	elseif v["falltype"] == "suipian" then
    		local record = self.weaponListModel:getWeaponRecord(v["id"])
			self.cardlabel[k]:setString("零件"..record["name"])
			local icon = display.newSprite("#icon_"..record["imgName"]..".png")
			icon:setScale(0.27)
			icon:setRotation(39)
			addChildCenter(icon, self.cardicon[k])
    	end
    end
    for i=1,table.nums(self.giveTable) do
    	self.lock[i]:setVisible(false)
    end
end

function FightResultLayer:playCard()
	for k,v in pairs(self.itemsTable) do
		local delay = k * 0.1
		function delayturn()
			local sequence = transition.sequence({cc.ScaleTo:create(0.3,0,1),cc.ScaleTo:create(0.3,1,1)})
			self.cardover[k]:runAction(sequence)
			self.card[k]:runAction(cc.ScaleTo:create(0.3,0,1))
		end
		self:performWithDelay(delayturn, delay)
	end
	for k,v in pairs(self.giveTable) do
		if v.falltype == "suipian" then
			function popUpSuipianNoti()
				self:popSuipianNotify(self.suipianId)
			end
			self:performWithDelay(popUpSuipianNoti, 1)
		elseif v.falltype == "gun" then
			function popUpGunNoti()
				self:popGunNotify(self.weaponId)
			end
			self:performWithDelay(popUpGunNoti, 1)
		end
	end
end

function FightResultLayer:onSentAward()
	self.giveTable,self.lockTable = self.fightResultModel:getRewardFall(self.grade)
	for k,v in pairs(self.giveTable) do
		table.insert(self.itemsTable,v)
		if v["falltype"] == "inlay" then
			local property = self.inlayModel:getInlayProperty(v["id"])
			if property ~= 4 then
				self.inlayModel:buyInlay(v["id"],2)
			else
				self.inlayModel:buyInlay(v["id"])
			end
		elseif v["falltype"] == "gun" then
			self.weaponId = v["id"]
		elseif v["falltype"] == "suipian" then
			self.levelDetailModel:setsuipian(v["id"])
			self.suipianId = v["id"]
		end
	end
	for k,v in pairs(self.lockTable) do
		table.insert(self.itemsTable,v)
	end
end

function FightResultLayer:popSuipianNotify(suipianId)
	ui:showPopup("WeaponNotifyLayer",
		 {type = "suipian",weaponId = suipianId},{opacity = 255})
end

function FightResultLayer:popGunNotify(weaponId)
	ui:showPopup("WeaponNotifyLayer",
		 {type = "gun",weaponId = weaponId, onCloseFunc = handler(self, self.checkGuide)},{opacity = 255})
end

function FightResultLayer:checkGuide()
	local guide 		= md:getInstance("Guide")
	local levelMapModel = md:getInstance("LevelMapModel")
	local curGroup, curLevel = levelMapModel:getConfig()
	if curGroup == 1 and curLevel == 1 then 
		guide:check("afterfight01")	
	end
	if curGroup == 1 and curLevel == 4 then 
		guide:check("afterfight03")	
	end
end

function FightResultLayer:quickInlay()
	self.inlayModel:equipAllInlays()
    local curGroup, curLevel = self.fightData["groupId"], self.fightData["levelId"]
	local levelInfo = curGroup.."_"..curLevel
	local umData = {}
    umData[levelInfo] = "快速镶嵌点击"
    um:event("关卡结算_快速镶嵌", umData)
end

function FightResultLayer:onCofirmLeftCard()
	if self.userModel:costDiamond(10) then
		self:onTurnLeftCard()
	else
        local buyModel = md:getInstance("BuyModel")
        buyModel:showBuy("stone120",{payDoneFunc = handler(self,self.onTurnLeftCard),isNotPopKefu = true},
         "战斗结算界面_点击翻牌")
	end
end

function FightResultLayer:onTurnLeftCard()
	for k,v in pairs(self.lockTable) do
        um:buy("翻拍", 1, 10)   
		if v["falltype"] == "inlay" then
			self.inlayModel:buyInlay(v["id"])
			table.insert(self.giveTable,{id = v["id"], falltype = "inlay"})
		elseif v["falltype"] == "gun" then
		elseif v["falltype"] == "suipian" then
		end
	end
	for k,v in pairs(self.lock) do
		if v:isVisible() == true then
			v:setVisible(false)
		end
	end
	self.btnGetAll:setButtonEnabled(false)
	self.alreadyGetAll:setVisible(true)
	self.alreadyGetAll:setScale(5)
	transition.execute(self.alreadyGetAll, cc.ScaleTo:create(0.2, 1), {
			    easing = "Out",
			})
	if self.getallArmature then
		self.getallArmature:removeFromParent()
		self.getallArmature = nil
	end
end

function FightResultLayer:startGuide()
	
end

function FightResultLayer:initGuide()
    local isDone = self.guide:isDone("afterfight01")
    if isDone then return end
    local fightData = {groupId = 1, fightType = "levelFight"}
    self.guide:addClickListener({
        id = "afterfight01_jixu",
        groupId = "afterfight01",
        rect = self.btnback:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
			ui:changeLayer("HomeBarLayer",{fightData = fightData})
        end
     })    	
end

function FightResultLayer:initGuide3()
    local isDone = self.guide:isDone("afterfight03")
    if isDone then return end
    self.guide:addClickListener({
        id = "afterfight03_inlay",
        groupId = "afterfight03",
        rect = self.btnInlay:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
	        ui:showPopup("commonPopup",
				 {type = "style2", content = "镶嵌成功"},
				 {opacity = 155})
        	self:quickInlay()
	        self.btnInlay:setButtonEnabled(false)  
			self.alreadyInlay:setVisible(true)
			self.alreadyInlay:setScale(5)
			transition.execute(self.alreadyInlay, cc.ScaleTo:create(0.2, 1), {
					    easing = "Out",
					})
			if self.inlayArmature then
				self.inlayArmature:removeFromParent()
				self.inlayArmature = nil
			end

			--镶嵌
            self.inlayModel:buyInlay(2,1) 
            self.inlayModel:buyInlay(5,1) 
            self.inlayModel:buyInlay(8,1) 
            self.inlayModel:buyInlay(11,1) 
            self.inlayModel:buyInlay(14,1) 
            self.inlayModel:buyInlay(17,1) 

            self.inlayModel:equipInlay(2)
            self.inlayModel:equipInlay(5)
            self.inlayModel:equipInlay(8)
            self.inlayModel:equipInlay(11)
            self.inlayModel:equipInlay(14)
            self.inlayModel:equipInlay(17)

		    playSoundBtn()    
        end
     }) 

    self.guide:addClickListener({
        id = "afterfight03_next",
        groupId = "afterfight03",
        rect = self.btnback:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
			self:onClickBtnNext()  
        end
     })       	
end

return FightResultLayer