
local InlayListCell = import(".InlayListCell")
local InlayModel = import(".InlayModel")

local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
    self.inlayModel = app:getInstance(InlayModel)
    self.InlayListCell = app:getInstance(InlayListCell)
	self.btn = {}

	self:loadCCS()
	self:initUI()
end

function InlayLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/InlayShop/xiangqian/")
	local controlNode = cc.uiloader:load("xiangqian_main.json")
    self.ui = controlNode
    self:addChild(controlNode)
end

function InlayLayer:initUI()
    self.rootListView = cc.uiloader:seekNodeByName(self, "listView")
    for i = 1, 6 do
        self.btn[i] = cc.uiloader:seekNodeByName(self, "panel"..i)
        self.btn[i]:setTouchEnabled(true)
        self.btn[i]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
                    print("aaa")

            if event.name=='began' then
                print("1 of 6 Btns is begining!")
                return true
            elseif event.name=='ended' then
                print("1 of 6 Btns is pressed!")
                self:refreshListView(i)
            end
        end)
    end

end

function InlayLayer:refreshListView(index)
	local typeId = {"speed", "aim", "clip", "bullet", 
	    "helper", "blood",}
    self:removeAllItems(self.rootListView)
    local table = self.inlayModel:getConfigTable("type", typeId[index])

    for i=1,#table do
    	local item = self.rootListView:newItem()
    	    -- dump(table[i])
    	local content = InlayListCell.new(table[i])
    	item:addContent(content)
        item:setItemSize(518, 160)
    	self.rootListView:addItem(item)
    end
    self.rootListView:reload()
end

function InlayLayer:removeAllItems(listView)
	local itemsNum_ = table.nums(listView.items_)

    if itemsNum_ > 0 then
    	listView:removeItem(listView.items_[1])
    	self:removeAllItems(listView)
    	return
    end

    return listView
end

return InlayLayer