local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local LoadingLayer = class("LoadingLayer", function()
	return display.newLayer()
end)

function LoadingLayer:ctor()
	self:loadCCS()
	self:initUI()
    self:showPercent()
	-- self:changeHomeLayer()
    self:setNodeEventEnabled(true)
    cc.EventProxy.new(ui, self)
        :addEventListener(ui.LOAD_SHOW_EVENT, handler(self, self.onShow))
        :addEventListener(ui.LOAD_HIDE_EVENT, handler(self, self.onHide))
    self:setVisible(false)
end

function LoadingLayer:loadCCS()
    local controlNode = cc.uiloader:load("res/Loading/loading/loading_1.json")
    self:addChild(controlNode)
end

function LoadingLayer:initUI()
	local quan = cc.uiloader:seekNodeByName(self, "quan")
    self.loadpercent = cc.uiloader:seekNodeByName(self, "loadpercent")
    self.loadpercent:enableOutline(cc.c3b( 0, 0, 0), 2)
	local yuansrc = "res/Loading/loading_yuan/loading_yuan.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(yuansrc)

    local yuanplist = "res/Loading/loading_yuan/loading_yuan0.plist"
    local yuanpng = "res/Loading/loading_yuan/loading_yuan0.png"
    display.addSpriteFrames(yuanplist,yuanpng)

    --anim    
    self.quanarmature = ccs.Armature:create("loading_yuan")
    self.quanarmature:setAnchorPoint(0.5,0.5)
    addChildCenter(self.quanarmature, quan)
end

function LoadingLayer:playAnim()
    self.quanarmature:getAnimation():play("loading_z")
end

function LoadingLayer:showPercent()
    local str = 1
    for i=1,100 do
        function setString()
            self.loadpercent:setString(str.."%")
            str = str+1
        end
        scheduler.performWithDelayGlobal(setString, i*0.03)
    end
end

function LoadingLayer:onShow(event)
    self:setVisible(true)
    self:playAnim()
    audio.stopMusic(true)
end

function LoadingLayer:onHide(event)
    self:setVisible(false)
end

return LoadingLayer