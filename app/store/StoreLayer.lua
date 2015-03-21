import("..includes.functionUtils")

local StoreCell = import(".StoreCell")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")


local StoreLayer = class("StoreLayer", function()
    return display.newLayer()
end)

function StoreLayer:ctor()
    self.storeModel = md:getInstance("StoreModel")
    
    cc.EventProxy.new(self.storeModel , self)
        :addEventListener("REFRESH_STORE_EVENT", handler(self, self.refresh))
end

function StoreLayer:onEnter()
    self:loadCCS()
    self:initUI()
    self:setSelect("prop")
end

function StoreLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/Store")
	local controlNode = cc.uiloader:load("shangcheng.ExportJson")
    if self.ui then
        return
    end
    self.ui = controlNode
    self:addChild(controlNode)

    display.addSpriteFrames("shangcheng0.plist", "shangcheng0.png")

end

function StoreLayer:initUI()
	self.listview = cc.uiloader:seekNodeByName(self, "listview")
	self.btnprop = cc.uiloader:seekNodeByName(self, "btnprop")
	self.btnbank = cc.uiloader:seekNodeByName(self, "btnbank")
	self.btninlay = cc.uiloader:seekNodeByName(self, "btninlay")
	self.btnprop:setTouchEnabled(true)
	self.btnbank:setTouchEnabled(true)
	self.btninlay:setTouchEnabled(true)
    self.btnprop:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
                self:setSelect("prop")
            end
        end)
     self.btnbank:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then 
            return true
        elseif event.name=='ended' then
            self:setSelect("bank")
        end
    end)
     self.btninlay:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then                
            return true
        elseif event.name=='ended' then
            self:setSelect("inlay")
        end
    end)
end

function StoreLayer:refresh(event)
    local type = event.typename
    self:setSelect(type)
end

function StoreLayer:refreshListView(type)
    removeAllItems(self.listview)
    local table = self.storeModel:getConfigTable(type)
    for i=1,#table do
        local item = self.listview:newItem()
        local content = StoreCell.new({record = table[i],celltype = type})
        item:addContent(content)
        item:setItemSize(758, 165)
        self.listview:addItem(item)
    end
    self.listview:reload()    
end

function StoreLayer:setSelect(type)
    self:refreshListView(type)
    self.btnprop:setColor(cc.c3b(80, 80, 80))
    self.btnbank:setColor(cc.c3b(80, 80, 80))
    self.btninlay:setColor(cc.c3b(80, 80, 80))
    if type == "inlay" then
        self.btninlay:setColor(cc.c3b(255, 255, 255))
    elseif type == "bank" then
        self.btnbank:setColor(cc.c3b(255, 255, 255))
    elseif type == "prop" then
        self.btnprop:setColor(cc.c3b(255, 255, 255))
    end
end

return StoreLayer