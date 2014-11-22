
local InlayListCell = import(".InlayListCell")
local InlayModel = import(".InlayModel")

local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
    self.inlayModel = app:getInstance(InlayModel)

    cc.EventProxy.new(self.inlayModel , self)
        :addEventListener("REFRESH_BTN_ICON_EVENT", handler(self, self.refreshBtnIcon))

	self.btn = {}
    self.btnImg = {}
    self.typeId = {"speed", "aim", "clip", "bullet", 
    "helper", "blood",}

	self:loadCCS()
	self:initUI()
    self:onEnter()

end

function InlayLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/InlayShop/")
	local controlNode = cc.uiloader:load("xiangqian_main.json")
    self.ui = controlNode
    self:addChild(controlNode)
end

function InlayLayer:onEnter()
    self:refreshListView("speed")
end

function InlayLayer:initUI()
    self.rootListView = cc.uiloader:seekNodeByName(self, "listView")
    self.oneForAllBtn = cc.uiloader:seekNodeByName(self, "oneForAllBtn")
    self.oneForAllBtn:setTouchEnabled(true)
    addBtnEventListener(self.oneForAllBtn, function(event)
        if event.name=='began' then
            -- print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
        end
    end)
    for k,v in pairs(self.typeId) do
        self.btnImg[v] = cc.uiloader:seekNodeByName(self, "panel"..v.."img")
    end
    for k,v in pairs(self.typeId) do

        self.btn[v] = cc.uiloader:seekNodeByName(self, "panel"..v)
        self.btn[v]:setTouchEnabled(true)
        self.btn[v]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then
                -- print("1 of 6 Btns is begining!")
                
                return true
            elseif event.name=='ended' then
                -- print("1 of 6 Btns is pressed!")
                self:refreshListView(v)    
            end
        end)
    end
    -- dump(self.btn)
end

function InlayLayer:refreshListView(index)
    self:removeAllItems(self.rootListView)
    local table = self.inlayModel:getConfigTable("type", index)
    for i=1,#table do
    	local item = self.rootListView:newItem()
    	local content = InlayListCell.new(table[i])
    	item:addContent(content)
        item:setItemSize(530, 160)
    	self.rootListView:addItem(item)
    end
    self.rootListView:reload()
end

function InlayLayer:refreshBtnIcon(parameterTable)
    if parameterTable.index == 0 then
        self.btnImg[parameterTable.string]:removeAllChildren()
    else
        local table = self.inlayModel:getConfigTable("id", parameterTable.index)
        local img = cc.ui.UIImage.new(table[1]["imgnam"]..".png")
        self.btnImg[parameterTable.string]:removeAllChildren()
        addChildCenter(img,self.btnImg[parameterTable.string])
    end
end

function InlayLayer:removeAllItems(listView)
	local itemsNum_ = table.nums(listView.items_)
    for i=1,itemsNum_ do
        listView:removeItem(listView.items_[1],false)
    end
    return listView
end

return InlayLayer