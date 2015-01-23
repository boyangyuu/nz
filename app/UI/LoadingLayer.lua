local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local LoadingLayer = class("LoadingLayer", function()
	return display.newLayer()
end)

function LoadingLayer:ctor()
	self:loadCCS()
	self:initUI()
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
	local src = "res/Loading/loading_bjmap/loading_bjmap.csb"
	local yuansrc = "res/Loading/loading_yuan/loading_yuan.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    manager:addArmatureFileInfo(yuansrc)

    --anim
    self.maparmature = ccs.Armature:create("loading_bjmap")
    self.maparmature :setAnchorPoint(0,0)
    main:addChild(self.maparmature )
    -- addChildCenter(self.maparmature , main)
    
    self.quanarmature = ccs.Armature:create("loading_yuan")
    self.quanarmature:setAnchorPoint(0.5,0.5)
    addChildCenter(self.quanarmature, quan)
end

function LoadingLayer:playAnim()
    self.maparmature :getAnimation():play("loading_bjmap")
    self.quanarmature:getAnimation():play("loading_z")
end

function LoadingLayer:onShow(event)
    self:setVisible(true)
    self:playAnim()
end

function LoadingLayer:onHide(event)
    self:setVisible(false)
end

return LoadingLayer