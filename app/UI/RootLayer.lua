
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

    --loading
    --todo

	--event
	cc.EventProxy.new(ui, self)
		:addEventListener(ui.LAYER_CHANGE_EVENT, handler(self, self.switchLayer))
end

function RootLayer:initLoginLayer()
    self.curLayer = HomeBarLayer.new()
    self:removeAllChildren()
    self:addChild(self.curLayer)    
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
    display.addSpriteFrames("weaponicon0.plist", "weaponicon0.png")
    --armature
end

function RootLayer:addResFight()
    --sprite
    display.addSpriteFrames("allImg0.plist", "allImg0.png")

    --armature
    local manager = ccs.ArmatureDataManager:getInstance()
    local enemyImgs = {"anim_enemy_002", "jinzhanb", "zibaob", "boss01","boss02", "dunbing", 
        "sanbing01", "daodan", "zpbing"}
 
    for i,v in ipairs(enemyImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, handler(self, self.dataLoaded))
    end

    local uiImgs = {"baotou", "hjwq", "huanzidan", "ruodiangj", "tanhao",
        "avatarhit", "blood1", "blood2", "gold", "shoulei", "danke"}
    for i,v in ipairs(uiImgs) do
        local src = "res/Fight/uiAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
    end

    local jqkImgs = {"effect_gun_jqk", "qkzd"} 
    for i,v in ipairs(jqkImgs) do
        local src = "res/Fight/jqkAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
    end 

    local gunImgs = {"anim_ak", "anim_jfzc", "anim_lmd", "anim_m4", "anim_m134",
        "anim_mp5", "anim_rpg", "anim_sy"}
    for i,v in ipairs(gunImgs) do
        local src = "res/Fight/gunsAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
    end    
end

function RootLayer:dataLoaded(percent)
    print(" dataLoaded() percent:"..percent)
    if percent == 1 then 
        self:initLoginLayer()
    end
end

return RootLayer