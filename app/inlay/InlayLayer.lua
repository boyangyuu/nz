--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 09:24:41
--
import("..includes.functionUtils")
local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
	self:init()
end

function InlayLayer:getSelf()
	return self
end

function InlayLayer:initUserdata()	
end


function InlayLayer:init()
	cc.FileUtils:getInstance():addSearchPath("res/Inlay/")
    self.inlayNode = cc.uiloader:load("xiangqian_0.ExportJson")
    self:addChild(self.inlayNode)

    self.btnUp = cc.uiloader:seekNodeByName(self.inlayNode, "btn_up")
    self.btnDown = cc.uiloader:seekNodeByName(self.inlayNode, "btn_down")
    self.btnLeft1 = cc.uiloader:seekNodeByName(self.inlayNode, "btn_left1")
    self.btnLeft2 = cc.uiloader:seekNodeByName(self.inlayNode, "btn_left2")
    self.btnLeft3 = cc.uiloader:seekNodeByName(self.inlayNode, "btn_left3")
    self.btnRight1 = cc.uiloader:seekNodeByName(self.inlayNode, "btn_right1")
    self.btnRight2 = cc.uiloader:seekNodeByName(self.inlayNode, "btn_right2")
    self.btnRight3 = cc.uiloader:seekNodeByName(self.inlayNode, "btn_right3")

    addBtnEventListener(self.btnUp, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        end
    end)
    addBtnEventListener(self.btnDown, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        end
    end)
   	self.btnLeft1:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            self:recoverColor()
            self.btnLeft1:setColor(cc.c3b(251, 252, 0))
        	return true
        elseif event.name=='ended' then
            
        end
    end)
    self.btnLeft2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            self:recoverColor()
            self.btnLeft2:setColor(cc.c3b(251, 252, 0))
        	return true
        elseif event.name=='ended' then
            
        end
    end)
    self.btnLeft3:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            self:recoverColor()
            self.btnLeft3:setColor(cc.c3b(251, 252, 0))
        	return true
        elseif event.name=='ended' then
            
        end
    end)
    self.btnRight1:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            self:recoverColor()
            self.btnRight1:setColor(cc.c3b(251, 252, 0))
        	return true
        elseif event.name=='ended' then
            
        end
    end)
    self.btnRight2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            self:recoverColor()
            self.btnRight2:setColor(cc.c3b(251, 252, 0))
        	return true
        elseif event.name=='ended' then
            
        end
    end)
    self.btnRight3:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            self:recoverColor()
            self.btnRight3:setColor(cc.c3b(251, 252, 0))
        	return true
        elseif event.name=='ended' then
            
        end
    end)
end

function InlayLayer:recoverColor()
	self.btnLeft1:setColor(cc.c3b(255, 255, 255))
	self.btnLeft2:setColor(cc.c3b(255, 255, 255))
	self.btnLeft3:setColor(cc.c3b(255, 255, 255))
	self.btnRight1:setColor(cc.c3b(255, 255, 255))
	self.btnRight2:setColor(cc.c3b(255, 255, 255))
	self.btnRight3:setColor(cc.c3b(255, 255, 255))
end

return InlayLayer