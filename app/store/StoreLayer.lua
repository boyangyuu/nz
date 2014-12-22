import("..includes.functionUtils")

local StoreCell = import(".StoreCell")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")


local StoreLayer = class("StoreLayer", function()
    return display.newLayer()
end)

function StoreLayer:ctor()
    self.storeModel = md:getInstance("StoreModel")

	self:loadCCS()
	self:initUI()
        self:refreshListView("inlay")
end

function StoreLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/Store")
	local controlNode = cc.uiloader:load("shangcheng.ExportJson")
    -- local cellNode = cc.uiloader:load("cellstore.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)

    display.addSpriteFrames("shangcheng0.plist", "shangcheng0.png")

end

function StoreLayer:initUI()
	self.listview = cc.uiloader:seekNodeByName(self, "listview")
	local btnprop = cc.uiloader:seekNodeByName(self, "btnprop")
	local btnbank = cc.uiloader:seekNodeByName(self, "btnbank")
	local btninlay = cc.uiloader:seekNodeByName(self, "btninlay")
	btnprop:setTouchEnabled(true)
	btnbank:setTouchEnabled(true)
	btninlay:setTouchEnabled(true)
    btnprop:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
                self:refreshListView("prop")
                btnprop:setLocalZOrder(100)
                btnbank:setLocalZOrder(-100) 
                btninlay:setLocalZOrder(-100) 
            end
        end)
     btnbank:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
                self:refreshListView("bank")
                btnprop:setLocalZOrder(-100)
                btnbank:setLocalZOrder(100) 
                btninlay:setLocalZOrder(-100)     
            end
        end)
     btninlay:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
                self:refreshListView("inlay")  
                btnprop:setLocalZOrder(-100)
                btnbank:setLocalZOrder(-100) 
                btninlay:setLocalZOrder(100)   
            end
        end)
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

return StoreLayer