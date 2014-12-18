
local HomeBarLayer = import("..homeBar.HomeBarLayer")
local LayerColor_BLACK = cc.c4b(0, 122, 44, 0)

local RootLayer = class("RootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function RootLayer:ctor()
	--instance
	
	--add res
    self:addResHome()
    self:addResFight()

    --login
    self.curLayer = HomeBarLayer.new()
    -- self.curLayer = FightResultFailPopup.new()
    self:addChild(self.curLayer)

	--event
	cc.EventProxy.new(ui, self)
		:addEventListener(ui.LAYER_CHANGE_EVENT, handler(self, self.switchLayer))
end

function RootLayer:switchLayer(event)
	-- dump(event, "event")
	local layer = event.layer
	self:removeAllChildren()

	self:addChild(layer)
end

function RootLayer:checkLoadLayer()
	
end

function RootLayer:addResHome()
    --sprite
    display.addSpriteFrames("allImg0.plist", "allImg0.png")

    --armature
end



function RootLayer:addResFight()
    --sprite
    display.addSpriteFrames("allImg0.plist", "allImg0.png")

    --armature
    local manager = ccs.ArmatureDataManager:getInstance()
    local enemyImgs = {"anim_enemy_002", "jinzhanb", "zibaob", "boss01","boss02", "dunbing", 
        "sanbing01", "daodan", "zpbing"}
    local function dataLoaded(percent)
        print(" dataLoaded() percent:"..percent)
    end    
    for i,v in ipairs(enemyImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, dataLoaded)
    end

    local uiImgs = {"baotou", "hjwq", "huanzidan", "ruodiangj", "tanhao",
        "avatarhit", "blood1", "blood2", "gold", "shoulei"}
    for i,v in ipairs(uiImgs) do
        local src = "res/Fight/uiAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, dataLoaded)
    end
end

return RootLayer