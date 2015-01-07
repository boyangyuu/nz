
local InlayListCell = import(".InlayListCell")

local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
    print("inlayLayer ctor()")

    self.inlayModel = md:getInstance("InlayModel")

    cc.EventProxy.new(self.inlayModel , self)
        :addEventListener("REFRESH_INLAY_EVENT", handler(self, self.refreshInlay))

	self.btn = {}
    self.typeId = {"speed", "crit", "clip", "bullet", 
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
    self:refreshAvatar()
end

function InlayLayer:refreshInlay(event)
    self:refreshBtnIcon(event)
    self:refreshListView(event.typename)
    self:refreshAvatar()
end
function InlayLayer:initUI()
    self.rootListView = cc.uiloader:seekNodeByName(self, "listview")
    local oneForAllBtn = cc.uiloader:seekNodeByName(self, "btnforall")
    local goldWeaponBtn = cc.uiloader:seekNodeByName(self, "btngoldweapon")
    
    self.iconarm = ccs.Armature:create("xqtb")
    self.avatarm = ccs.Armature:create("xqan_hjwqbs")
    local armature = ccs.Armature:create("xqan_hjwq")
    addChildCenter(armature, goldWeaponBtn)
    armature:getAnimation():play("Animation1" , -1, 1)


    self.goldgun = cc.uiloader:seekNodeByName(self, "d")
    self.goldgun:setVisible(false)
    oneForAllBtn:setTouchEnabled(true)
    goldWeaponBtn:setTouchEnabled(true)
    addBtnEventListener(oneForAllBtn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self.inlayModel:equipAllInlays()
            md:getInstance("StoreModel"):setGoldWeaponNum()
        end
    end)

    addBtnEventListener(goldWeaponBtn, function(event)
        if event.name=='began' then
            -- print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self.inlayModel:equipGoldInlays(true)
            md:getInstance("StoreModel"):setGoldWeaponNum()
        end
    end)

    for k,v in pairs(self.typeId) do
        self.btn[v] = cc.uiloader:seekNodeByName(self, "panel"..v)
        self.btn[v]:setTouchEnabled(true)
        self.btn[v]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
                -- local selectarm = ccs.Armature:create("xqtb")
                -- selectarm:getAnimation():setMovementEventCallFunc(
                --     function ( armatureBack,movementType,movementId ) 
                --         if movementType == ccs.MovementEventType.complete then
                --             armatureBack:removeSelf()
                --         end
                --     end)
                -- addChildCenter(selectarm, self.btn[v])
                -- selectarm:getAnimation():play("xqtb" , -1, 1)

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

function InlayLayer:refreshAvatar()
    if self.inlayModel:isGetAllGold() then
        self.goldgun:setVisible(true)
    else
        print("takeoff")
        self.goldgun:setVisible(false)
    end
end

function InlayLayer:refreshBtnIcon(event)
    local allInlayed = self.inlayModel:getAllInlayed()
    for k,v in pairs(self.btn) do
        self.btn[k]:removeAllChildren()
    end
    dump(allInlayed, "allInlayed")
    for k,v in pairs(allInlayed) do
        local table = self.inlayModel:getConfigTable("id", v)
        local img =  display.newSprite("#"..table[1]["imgname"]..".png")
        addChildCenter(img,self.btn[k])
    end

    if event then    
        if event.isall then
            for k,v in pairs(allInlayed) do
                local equiparm = ccs.Armature:create("xqzb")
                equiparm:getAnimation():setMovementEventCallFunc(
                    function ( armatureBack,movementType,movementId ) 
                        if movementType == ccs.MovementEventType.complete then
                            armatureBack:removeSelf()
                        end
                    end)
                addChildCenter(equiparm, self.btn[k])
                equiparm:getAnimation():play("Animation1" , -1, 0)
            end
            return
        elseif event.typename then
            local equiparm = ccs.Armature:create("xqzb")
            equiparm:getAnimation():setMovementEventCallFunc(
                function ( armatureBack,movementType,movementId ) 
                    if movementType == ccs.MovementEventType.complete then
                        armatureBack:removeSelf()
                    end
                end)
            addChildCenter(equiparm, self.btn[event.typename])
            equiparm:getAnimation():play("Animation1" , -1, 0)

        end
    end

    

end

return InlayLayer