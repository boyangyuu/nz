-- local LayerColor_WHITE = cc.c4b(0, 0, 0, 0)
local commonPopup = class("commonPopup",function()
	return display.newLayer()
	-- return display.newColorLayer(LayerColor_WHITE)
end)

--[[
	style1:一个确定按钮，一个关闭按钮，content
		ui:showPopup("commonPopup",
			 {type = "style1",content = "必须装备狙击枪"},
			 {opacity = 0})
	style2:只有一个板，没有按钮，三秒消失
		ui:showPopup("commonPopup",
			 {type = "style2", content = "本关还没开启"},
			 {opacity = 0})
	style3:俩按钮，确定取消，content
		ui:showPopup("commonPopup",
			 {type = "style3", content = "必须装备狙击枪"},
			 {opacity = 0})
	style4:仨按钮, 确定取消打电话
		ui:showPopup("commonPopup",
			 {type = "style4",opacity = 0}
		)
]]
function commonPopup:ctor(properties)
	self.commonPopModel = md:getInstance("commonPopModel")

	self.properties = properties
	local typeName = properties.type
	self:loadCCS(typeName)
	self:initUI(properties)
end

function commonPopup:loadCCS(typeName)
    cc.FileUtils:getInstance():addSearchPath("res/CommonPopup/erjijiemian")
    local controlNode = cc.uiloader:load(typeName..".ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)

end

function commonPopup:initUI(properties)
	local typeName = properties.type
	if typeName == "style1" then
		local content = cc.uiloader:seekNodeByName(self, "content")
		content:setString(properties.content)
	    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
	    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    	btntrue:setTouchEnabled(true)
    	btnfalse:setTouchEnabled(true)
    	addBtnEventListener(btntrue, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self:onClickCofirm()

	        end
	    end)
    	addBtnEventListener(btnfalse, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self:onClickClose()
	        end
	    end)

	elseif typeName == "style2" then
	    local labelTip = cc.uiloader:seekNodeByName(self, "Label_tip")
	    local panl_style2 = cc.uiloader:seekNodeByName(self, "panl_style2")
	    labelTip:setString(properties.content)
	    panl_style2:setTouchEnabled(true)
	    panl_style2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
	        if event.name=='began' then
	            ui:closePopup("commonPopup")
	            return true
	        end
	    end)

	    -- auto remove popup windows after 2 secs.
	    self:runAction(transition.sequence({cc.DelayTime:create(2), cc.CallFunc:create(function()
            ui:closePopup("commonPopup")
        end)}))

	elseif typeName == "style3" then
		local content = cc.uiloader:seekNodeByName(self, "content")
		content:setString(properties.content)
	    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
	    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    	btntrue:setTouchEnabled(true)
    	btnfalse:setTouchEnabled(true)
    	addBtnEventListener(btntrue, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self:onClickCofirm()
	        end
	    end)
    	addBtnEventListener(btnfalse, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		

		     self:onClickClose()
	        end
	    end)

	elseif typeName == "style4" then
		local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
		local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
		local btncall = cc.uiloader:seekNodeByName(self, "btncall")
		btntrue:setTouchEnabled(true)
		btnfalse:setTouchEnabled(true)
		btncall:setTouchEnabled(true)

		addBtnEventListener(btntrue, function( event )
			if event.name == "began" then
				return true
			elseif event.name == "ended" then
				print("btntrue is pressed!") 
				ui:closePopup("commonPopup")
			end
		end)

		addBtnEventListener(btnfalse, function( event )
			if event.name == "began" then
				return true
			elseif event.name == "ended" then
				print("btnfalse is pressed!")
				ui:closePopup("commonPopup")
			end
		end)

		btncall:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
			if event.name == "began" then
				print("btncall is pressed!")
				return true
			elseif event.name == "ended" then
				
				if device.platform == "android" then
					local className = "com/hgtt/ccn/IAPControl"
					luaj.callStaticMethod(className, "callPhone")
					um:event("kefu")
					print("btncall is pressed!")
				end
			end
		end)

	end
end

function commonPopup:onClickCofirm()
	-- if self.properties.type == "style3" and self.properties.isPauseScene then 
	-- 	print("commonPopup:onClickCofirm() isPauseScene")
	-- 	local buyModel = md:getInstance("BuyModel")
	-- 	if buyModel:checkBought("weaponGiftBag") == false then
	-- 		print("buyModel:checkBought(weaponGiftBag) == false ")
	-- 		buyModel:buy("weaponGiftBag", {
 --                    payDoneFunc = self.properties.callfuncCofirm,
 --                    deneyBuyFunc = self.properties.callfuncCofirm, 
 --                    isFight = true, isPauseSecond = true})
	-- 	else
	-- 		buyModel:buy("goldGiftBag", {
 --                    payDoneFunc = self.properties.callfuncCofirm,
 --                    deneyBuyFunc = self.properties.callfuncCofirm,
 --                     isFight = true, isPauseSecond = true})
	-- 	end
	-- else
		ui:closePopup("commonPopup")
		local func =  self.properties.callfuncCofirm
		if func ~= nil then
			print("callfuncCofirm")
			func()		
		end
	-- end
end

function commonPopup:onClickClose()
	-- if self.properties.type == "style3" and self.properties.isPauseScene then 
	-- 	cc.Director:getInstance():popScene()
	-- else
		
	-- end	
	ui:closePopup("commonPopup")
	local func =  self.properties.callfuncClose
	if func ~= nil then
		print("callfuncClose")  
		func()
	end	
end

return commonPopup