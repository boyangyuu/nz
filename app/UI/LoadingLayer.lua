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
    local controlNode = cc.uiloader:load("res/Loading/loading/loading_1.ExportJson")
    self:addChild(controlNode)
end

function LoadingLayer:initUI()
	local main = cc.uiloader:seekNodeByName(self, "main")
	local quan = cc.uiloader:seekNodeByName(self, "quan")
    self.loadpercent = cc.uiloader:seekNodeByName(self, "loadpercent")
    self.loadpercent:enableOutline(cc.c3b( 0, 0, 0), 2)
	local src = "res/Loading/loading_bjmap/loading_bjmap.csb"
	local yuansrc = "res/Loading/loading_yuan/loading_yuan.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    manager:addArmatureFileInfo(yuansrc)

    local plist = "res/Loading/loading_bjmap/loading_bjmap0.plist"
    local png = "res/Loading/loading_bjmap/loading_bjmap0.png"
    display.addSpriteFrames(plist,png)

    --anim
    self.maparmature = ccs.Armature:create("loading_bjmap")
    self.maparmature :setAnchorPoint(0,0)
    main:addChild(self.maparmature)
    
    self.quanarmature = ccs.Armature:create("loading_yuan")
    self.quanarmature:setAnchorPoint(0.5,0.5)
    addChildCenter(self.quanarmature, quan)
end

function LoadingLayer:playAnim()
    self.maparmature :getAnimation():play("loading_bjmap")
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
    audio.stopMusic(false)
end

function LoadingLayer:onHide(event)
    self:setVisible(false)
end

return LoadingLayer