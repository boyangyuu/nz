local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local LoadingLayer = class("LoadingLayer", function()
	return display.newLayer()
end)

function LoadingLayer:ctor()
	self:loadCCS()
	self:initUI()
	self:changeHomeLayer()
end

function LoadingLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/Loading/loading")
    local controlNode = cc.uiloader:load("loading_1.ExportJson")
    self:addChild(controlNode)
end

function LoadingLayer:initUI( )
	local main = cc.uiloader:seekNodeByName(self, "main")
	local quan = cc.uiloader:seekNodeByName(self, "quan")
	local src = "res/Loading/loading_bjmap/loading_bjmap.csb"
	local yuansrc = "res/Loading/loading_yuan/loading_yuan.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    manager:addArmatureFileInfo(yuansrc)

    --anim
    local maparmature = ccs.Armature:create("loading_bjmap")
    maparmature:setAnchorPoint(0,0)
    maparmature:setPosition(0,30)
    main:addChild(maparmature)
    maparmature:getAnimation():play("loading_bjmap")
    local quanarmature = ccs.Armature:create("loading_yuan")
    quanarmature:setAnchorPoint(0.5,0.5)
    addChildCenter(quanarmature, quan)
    quanarmature:getAnimation():play("loading_z")


end

function LoadingLayer:changeHomeLayer()
	function delayShow()
		ui:changeLayer("HomeBarLayer", {})
	end
	scheduler.performWithDelayGlobal(delayShow, 3)
end

return LoadingLayer