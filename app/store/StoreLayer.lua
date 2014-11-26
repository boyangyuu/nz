local StoreModel = import(".StoreModel")
local StoreInlayCell = import(".StoreInlayCell")
local StorePropCell = import(".StorePropCell")

local StoreLayer = class("StoreLayer", function()
    return display.newLayer()
end)

function StoreLayer:ctor()
    self.storeModel = app:getInstance(StoreModel)

	self:loadCCS()
	self:initUI()
end

function StoreLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/Store")
	local controlNode = cc.uiloader:load("shangcheng.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)
end

function StoreLayer:initUI()
	self.listview = cc.uiloader:seekNodeByName(self, "listview")
	local btnprop = cc.uiloader:seekNodeByName(self, "btnprop")
	local btnbank = cc.uiloader:seekNodeByName(self, "btnbank")
	local btninlay = cc.uiloader:seekNodeByName(self, "btninlay")
	btnprop:setTouchEnabled(true)
	btnbank:setTouchEnabled(true)
	btninlay:setTouchEnabled(true)

	addBtnEventListener(btnprop, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        	self:refreshListView("prop")

        end
    end)
	 addBtnEventListener(btnbank, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then

        end
    end)
	 addBtnEventListener(btninlay, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        	self:refreshListView("inlay")
        end
    end)
end

function StoreLayer:refreshListView(type)
    removeAllItems(self.listview)
	if type == "prop" then
	    local table = self.storeModel:getPropConfigTable()
	    for i=1,#table do
	    	local item = self.listview:newItem()
	    	local content = StorePropCell.new(table[i])
	    	item:addContent(content)
	        item:setItemSize(735, 157)
	    	self.listview:addItem(item)
	    end
	elseif type == "bank" then

	elseif type == "inlay" then
		local table = self.storeModel:getInlayConfigTable()
	    for i=1,#table do
	    	local item = self.listview:newItem()
	    	local content = StoreInlayCell.new(table[i])
	    	item:addContent(content)
	        item:setItemSize(735, 157)
	    	self.listview:addItem(item)
	    end
	end
    self.listview:reload()
end

return StoreLayer