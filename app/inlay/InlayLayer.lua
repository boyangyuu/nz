
local InlayListCell = import(".InlayListCell")
local InlayModel = import(".InlayModel")

local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
    print("inlayLayer ctor()")

    self.inlayModel = app:getInstance(InlayModel)

    cc.EventProxy.new(self.inlayModel , self)
        :addEventListener("REFRESH_INLAY_EVENT", handler(self, self.refreshInlay))

	self.btn = {}
    self.typeId = {"speed", "aim", "clip", "bullet", 
    "helper", "blood",}

	self:loadCCS()
	self:initUI()
    self:onEnter()

end

function InlayLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/InlayShop")
    local controlNode = cc.uiloader:load("xiangqian.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)

    display.addSpriteFrames("xiangqian0.plist", "xiangqian0.png")


end

function InlayLayer:onEnter()
    self:refreshBtnIcon()
    self:refreshListView("speed")
end

function InlayLayer:refreshInlay(event)
    self:refreshBtnIcon()
    self:refreshListView(event.typename)
end
function InlayLayer:initUI()
    self.rootListView = cc.uiloader:seekNodeByName(self, "listview")
    local oneForAllBtn = cc.uiloader:seekNodeByName(self, "btnforall")
    local goldWeaponBtn = cc.uiloader:seekNodeByName(self, "btngoldweapon")
    oneForAllBtn:setTouchEnabled(true)
    goldWeaponBtn:setTouchEnabled(true)
    addBtnEventListener(oneForAllBtn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self.inlayModel:oneForAllBtn()
        end
    end)

    addBtnEventListener(goldWeaponBtn, function(event)
        if event.name=='began' then
            -- print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            local data = getUserData()
            for k,v in pairs(data.inlay.inlayed) do
                for i=1,#data.inlay.inlayed[k] do
                    table.remove(data.inlay.inlayed[k],1)
                end
            end
            setUserData(data)
            -- dump(GameState.load())
            self:refreshBtnIcon()
        end
    end)

    for k,v in pairs(self.typeId) do
        self.btn[v] = cc.uiloader:seekNodeByName(self, "panel"..v)
        self.btn[v]:setTouchEnabled(true)
        self.btn[v]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
                self:refreshListView(v)    
            end
        end)
    end
end

function InlayLayer:refreshListView(index)
    removeAllItems(self.rootListView)
    local table = self.inlayModel:getConfigTable("type", index)
    for i=1,#table do
    	local item = self.rootListView:newItem()
    	local content = InlayListCell.new(table[i])
    	item:addContent(content)
        item:setItemSize(550, 165)
    	self.rootListView:addItem(item)
    end
    self.rootListView:reload()
end

function InlayLayer:refreshBtnIcon()
    local allInlayed = self.inlayModel:getAllInlayed()
    for k,v in pairs(self.btn) do
        self.btn[k]:removeAllChildren()
    end
    dump(allInlayed, "allInlayed")
    for k,v in pairs(allInlayed) do
        local table = self.inlayModel:getConfigTable("id", v.index)
        local img =  display.newSprite("#"..table[1]["imgnam"]..".png")
        addChildCenter(img,self.btn[v.typename])
    end

end



return InlayLayer