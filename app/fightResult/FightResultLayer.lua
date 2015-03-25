local scheduler			 = require(cc.PACKAGE_NAME .. ".scheduler")
local Color_BLACK = cc.c3b(0, 0, 0)
local FightResultLayer = class("FightResultLayer", function()
	return display.newLayer()
end)

function FightResultLayer:ctor(properties)
    self.fightModel 	  = md:getInstance("Fight")
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
 
    local fightResult = self.fightModel:getResultData()
    local UserModel = md:getInstance("UserModel")
    UserModel:addMoney(fightResult["goldNum"])
    dump(fightResult["goldNum"])
    um:bonusVirtualCurrency(fightResult["goldNum"],4)
    self.grade = self:getGrade(fightResult["hpPercent"])

	self:getinlayfall()
	self:loadCCS()
	self:setDailyPopup()
	self:initUI()
	self:initUIContent()
	self:playSound()

	self:playstar(self.grade)
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

local playStarHandler = nil
function FightResultLayer:playstar(numStar)
	local posXinterval = 112
	for i=1,numStar do
		local delay = i * 0.5
		local function starcall()
		    local starArmature = ccs.Armature:create("gkjs_xing")
		    starArmature:setPosition(43.5,42)
		    self.star[i]:addChild(starArmature)
		    if i == numStar then
		    	starArmature:getAnimation():setMovementEventCallFunc(
		    		function(armatureBack,movementType,movementId ) 
	                if movementType == ccs.MovementEventType.complete then
		         		self:playCard()
		         		scheduler.performWithDelayGlobal(showButton, 1)
		         	end    
	            end)
		    end
			starArmature:getAnimation():play("gkjs_xing" , -1, 0)
		    local zx = "res/Music/ui/zx.wav"
		    audio.playSound(zx,false)
		end
		playStarHandler = scheduler.performWithDelayGlobal(starcall, delay)
	end
end


function FightResultLayer:initUI()
    for i=1,5 do
    	self.star[i] = cc.uiloader:seekNodeByName(self, "panelstar"..i)
	end
    for i=1,6 do
    	self.cardgold[i] = cc.uiloader:seekNodeByName(self, "cardgold"..i)
    	self.cardsilver[i] = cc.uiloader:seekNodeByName(self, "cardsilver"..i)
    	self.cardbronze[i] = cc.uiloader:seekNodeByName(self, "cardbronze"..i)
    	self.cardover[i] = cc.uiloader:seekNodeByName(self, "cardover"..i)
    	self.cardicon[i] = cc.uiloader:seekNodeByName(self, "icon"..i)
    	self.cardlabel[i] = cc.uiloader:seekNodeByName(self, "labelcard"..i)
    	self.card[i] = cc.uiloader:seekNodeByName(self, "card"..i)
    	self.lock[i] = cc.uiloader:seekNodeByName(self, "suo"..i)
    	self.cardover[i]:setScaleX(0)
    end

    self.btninlay = cc.uiloader:seekNodeByName(self, "btninlay")
    self.btngetall = cc.uiloader:seekNodeByName(self, "btngetall")
    self.panlinlay = cc.uiloader:seekNodeByName(self, "panlinlay")
    self.alreadyinlay = cc.uiloader:seekNodeByName(self, "alreadyinlay")
    self.alreadygetall = cc.uiloader:seekNodeByName(self, "alreadygetall")
    self.panlgetall = cc.uiloader:seekNodeByName(self, "panlgetall")
    self.btnback = cc.uiloader:seekNodeByName(self, "btnnext")
	self.alreadyinlay:setVisible(false)
	self.alreadygetall:setVisible(false)
	self.btninlay:setOpacity(0)
	self.btngetall:setOpacity(0)
	self.btninlay:setButtonEnabled(false)
	self.btngetall:setButtonEnabled(false)
	self.btnback:setButtonEnabled(false)

    self.inlayArmature = ccs.Armature:create("bt_ksxq")
    self.getallArmature = ccs.Armature:create("bt_ksxq")
    self.btninlay:addChild(self.inlayArmature)
    self.btngetall:addChild(self.getallArmature)
    self.inlayArmature:getAnimation():play("yjzb" , -1, 1)
    self.getallArmature:getAnimation():play("yjzb" , -1, 1)

	function showButton()
		self:startGuide()

		self.btngetall:setButtonEnabled(true)
		self.btninlay:setButtonEnabled(true)
		self.btngetall:runAction(cc.FadeIn:create(0.3))
		self.btninlay:runAction(cc.FadeIn:create(0.3))

		if table.nums(self.lockTable) == 0 then
			self.btngetall:setButtonEnabled(false)
			self.alreadygetall:setVisible(true)
			self.alreadygetall:setScale(5)
			transition.execute(self.alreadygetall, cc.ScaleTo:create(0.2, 1), {
					    easing = "Out",
					})
			if self.getallArmature then
				self.getallArmature:removeFromParent()
				self.getallArmature = nil
			end
		end
		self.btnback:setButtonEnabled(true)


	    local curGroup, curLevel = self.fightModel:getCurGroupAndLevel()
		local levelInfo = curGroup.."_"..curLevel
		local umData = {}
	    umData[levelInfo] = "快速镶嵌展示"
	    um:event("关卡结算_快速镶嵌", umData)

	end

    addBtnEventListener(self.btninlay, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
	        ui:showPopup("commonPopup",
				 {type = "style2", content = "镶嵌成功",delay = 0.5},
				 {opacity = 155})				
        	self:quickInlay()
	        self.btninlay:setButtonEnabled(false)
			self.alreadyinlay:setVisible(true)
			self.alreadyinlay:setScale(5)
			transition.execute(self.alreadyinlay, cc.ScaleTo:create(0.2, 1), {
					    easing = "Out",
					})
			if self.inlayArmature then
				self.inlayArmature:removeFromParent()
				self.inlayArmature = nil
			end
        end
    end)

    addBtnEventListener(self.btngetall, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
	        ui:showPopup("commonPopup",
				 {type = "style1", content = "是否花费10颗钻石翻开剩余卡牌",
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

function FightResultLayer:onClickBtnNext()
    local curGroup, curLevel = self.fightModel:getCurGroupAndLevel()

    --todo
    if curLevel == 6 and curGroup < 4 then
    	curGroup = curGroup + 1
    end
	local isCurLevel = self.levelMapModel:isCureGroupAndLevel(curGroup, curLevel)

	--check guide
	local guide = md:getInstance("Guide")
	local isGuidedWeapon = guide:isDone("weapon")
	local isPopupNext = isGuidedWeapon and true or false

	if isCurLevel then
		ui:changeLayer("HomeBarLayer",{groupId = curGroup,isPopupNext = isPopupNext})
	else
		print("1-4.1 OR 通关")
    	ui:changeLayer("HomeBarLayer",{groupId = curGroup})
    end
end

function FightResultLayer:initUIContent()
    for k,v in pairs(self.itemsTable) do
    	if v["falltype"] == "gun" then
    		local record = self.weaponListModel:getWeaponRecord(v["id"])
			self.cardlabel[k]:setString(record["name"])
			local icon = display.newSprite("#icon_"..record["imgName"]..".png")
			icon:setScale(0.27)
			icon:setRotation(39)
			addChildCenter(icon, self.cardicon[k])
    	elseif v["falltype"] == "inlay" then
    		local record = self.fightResultModel:getInlayrecordByID(v["id"])
			self.cardlabel[k]:setString(record["describe2"])
			local icon = display.newSprite("#"..record["imgname"]..".png")
			addChildCenter(icon, self.cardicon[k])
			if record["property"] == 2 then
				self.cardgold[k]:setVisible(false)
				self.cardsilver[k]:setVisible(false)
			elseif record["property"] == 3 then
				self.cardgold[k]:setVisible(false)
				dump(k)
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
		scheduler.performWithDelayGlobal(delayturn, delay)
	end
	for k,v in pairs(self.giveTable) do
		if v.falltype == "suipian" then
			function popUpNoti()
				self:popSuipianNotify(self.suipianId)
			end
			scheduler.performWithDelayGlobal(popUpNoti, 1.5)
		end
	end
end

function FightResultLayer:getinlayfall()
	local giveTable = {}
	local lockTable = {}
	local probaTable = {}
    local config = getConfig("config/inlayfall.json")
	local curGroup, curLevel = self.fightModel:getCurGroupAndLevel()
	self.curRecord = self.levelDetailModel:getConfig(curGroup, curLevel)
	local isWeaponAlreadyTogether = self.weaponListModel:isWeaponExist(self.curRecord["suipianid"])
	
	-- 武器碎片
	if self.curRecord["type"] == "boss" and isWeaponAlreadyTogether == false then
		table.insert(probaTable,{id = self.curRecord["suipianid"],falltype = "suipian"})
		table.insert(giveTable,{id = self.curRecord["suipianid"],falltype = "suipian"})
	end

	-- 狙击 & MP5
    if  curGroup == 0 and curLevel == 0 then
	    table.insert(probaTable,{id = 2, falltype = "gun"}) 
	    table.insert(giveTable,{id = 2, falltype = "gun"})
    elseif curGroup == 1 and curLevel == 3 then
    	table.insert(probaTable,{id = 6, falltype = "gun"}) 
	    table.insert(giveTable,{id = 6, falltype = "gun"})
	end

	-- 黄金镶嵌
	local rans = math.random(100)
	local sptable = getRecordByKey("config/inlayfall.json","type","special")
	local totals = 0
	local ran = math.random(1, 100)
	for k,v in pairs(sptable) do
		totals = totals + v["probability"]
		if totals >= rans then
			table.insert(probaTable,{id = v["inlayid"], falltype = "inlay"})
			if self.grade == 6 - table.nums(lockTable) then
				table.insert(giveTable,{id = v["inlayid"], falltype = "inlay"})
			elseif ran < 5 and self.grade > table.nums(giveTable) then
				table.insert(giveTable,{id = v["inlayid"], falltype = "inlay"})
			elseif self.grade == 5 then
				table.insert(giveTable,{id = v["inlayid"], falltype = "inlay"})
			else
				table.insert(lockTable,{id = v["inlayid"], falltype = "inlay"})
			end
			break
		end
	end

	-- 普通镶嵌
	local givenum = self.grade + 1 - table.nums(giveTable)
	local inserttable = {}
	local normalnum = 6 - table.nums(probaTable)
	local index = 1
	for i=1,normalnum do
		local ran = math.random(100)
		local total = 0
		for k,v in pairs(config) do
			total = total + v["probability"]
			if total >= ran then
				inserttable = {id = v["inlayid"],falltype = "inlay"}
				table.insert(probaTable,1,inserttable)
				if index <= givenum then
					table.insert(giveTable,1,inserttable)
				else
					table.insert(lockTable,1,inserttable)
				end
				index = index + 1
				break
			end
		end
	end
	self.giveTable = giveTable
	self.lockTable = lockTable
	for k,v in pairs(giveTable) do
		table.insert(self.itemsTable,v)
		if v["falltype"] == "inlay" then
			self.inlayModel:buyInlay(v["id"])
		elseif v["falltype"] == "gun" then
			--掉落雷明顿，turnLeftCard弹出提示
		elseif v["falltype"] == "suipian" then
			self.levelDetailModel:setsuipian(v["id"])
			-- self.suipianName = self.weaponListModel:getWeaponNameByID(v["id"])
			self.suipianId = v["id"]
		end
	end
	for k,v in pairs(lockTable) do
		table.insert(self.itemsTable,v)
	end
	dump(self.itemsTable)
end

function FightResultLayer:popSuipianNotify(suipianId)
	-- ui:showPopup("commonPopup",
	-- 	 {type = "style2", content = "恭喜获得"..name.."零件 X1！",delay = 0.5},
	-- 	 {opacity = 155})
		ui:showPopup("WeaponNotifyLayer",
			 {type = "suipian",weaponId = suipianId})

end

function FightResultLayer:getGrade(LeftPersent)
	if LeftPersent < 0.2 then
		return 3
	elseif LeftPersent < 0.6 then
		return 4
	else
		return 5
	end
end

function FightResultLayer:quickInlay()
	self.inlayModel:equipAllInlays()
    local curGroup, curLevel = self.fightModel:getCurGroupAndLevel()
	local levelInfo = curGroup.."_"..curLevel
	local umData = {}
    umData[levelInfo] = "快速镶嵌点击"
    um:event("关卡结算_快速镶嵌", umData)
end

function FightResultLayer:onCofirmLeftCard()
	if self.userModel:costDiamond(10) then
		self:turnLeftCard()
	else
        local buyModel = md:getInstance("BuyModel")
        buyModel:showBuy("stone120",{payDoneFunc = handler(self,self.turnLeftCard)},
         "战斗结算界面_点击翻牌")
	end
end

function FightResultLayer:turnLeftCard()
	for k,v in pairs(self.lockTable) do
        um:buy("翻拍", 1, 10)   
		if v["falltype"] == "inlay" then
			self.inlayModel:buyInlay(v["id"])
			table.insert(self.giveTable,{id = v["id"], falltype = "inlay"})
		elseif v["falltype"] == "gun" then
			self.weaponListModel:buyWeapon(v["id"])
			self.weaponListModel:equipBag(v["id"],3)
			function delaypopgun()
				-- ui:showPopup("commonPopup",
				-- 	 {type = "style2", content = "恭喜获得雷明顿！",delay = 0.5},
				-- 	 {opacity = 155})
				ui:showPopup("WeaponNotifyLayer",
					 {type = "gun",weaponId = v["id"]})

			end
			scheduler.performWithDelayGlobal(delaypopgun, 0.5)
		elseif v["falltype"] == "suipian" then
		end
	end
	for k,v in pairs(self.lock) do
		if v:isVisible() == true then
			v:setVisible(false)
		end
	end
	self.btngetall:setButtonEnabled(false)
	self.alreadygetall:setVisible(true)
	self.alreadygetall:setScale(5)
	transition.execute(self.alreadygetall, cc.ScaleTo:create(0.2, 1), {
			    easing = "Out",
			})
	if self.getallArmature then
		self.getallArmature:removeFromParent()
		self.getallArmature = nil
	end
end

function FightResultLayer:onEnter()
end

function FightResultLayer:setDailyPopup()
    local dailyLoginModel = md:getInstance("DailyLoginModel")
    local guide = md:getInstance("Guide")
	local isGet = dailyLoginModel:isGet()
	if isGet == false then
		dailyLoginModel:setPopup()
	end
end

function FightResultLayer:startGuide()
	self.guide:check("afterfight01")	
	self.guide:check("afterfight03")
end

function FightResultLayer:initGuide()
    local isDone = self.guide:isDone("afterfight01")
    if isDone then return end
    self.guide:addClickListener({
        id = "afterfight01_award",
        groupId = "afterfight01",
       rect = cc.rect(0, 0, display.width1, display.height1),
        endfunc = function (touchEvent)
        	playSoundBtn()
        end
     })  


    self.guide:addClickListener({
        id = "afterfight01_get",
        groupId = "afterfight01",
        rect = self.btngetall:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
			self:turnLeftCard()   
			playSoundBtn()    
        end
     })   
    self.guide:addClickListener({
        id = "afterfight01_jixu",
        groupId = "afterfight01",
        rect = self.btnback:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
			ui:changeLayer("HomeBarLayer",{groupId = 1,isPopupNext = isPopupNext})   
        end
     })    	
end

function FightResultLayer:initGuide3()
    local isDone = self.guide:isDone("afterfight03")
    if isDone then return end
    self.guide:addClickListener({
        id = "afterfight03_inlay",
        groupId = "afterfight03",
        rect = self.btninlay:getCascadeBoundingBox(),
        endfunc = function (touchEvent)
	        ui:showPopup("commonPopup",
				 {type = "style2", content = "镶嵌成功"},
				 {opacity = 155})
        	self:quickInlay()
	        self.btninlay:setButtonEnabled(false)  
			self.alreadyinlay:setVisible(true)
			self.alreadyinlay:setScale(5)
			transition.execute(self.alreadyinlay, cc.ScaleTo:create(0.2, 1), {
					    easing = "Out",
					})
			if self.inlayArmature then
				self.inlayArmature:removeFromParent()
				self.inlayArmature = nil
			end

			--镶嵌
           self.inlayModel:buyInlay(2,false,1) 
           self.inlayModel:buyInlay(5,false,1) 
           self.inlayModel:buyInlay(8,false,1) 
           self.inlayModel:buyInlay(11,false,1) 
           self.inlayModel:buyInlay(14,false,1) 
           self.inlayModel:buyInlay(17,true,1) 
           self.inlayModel:equipAllInlays(true)

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