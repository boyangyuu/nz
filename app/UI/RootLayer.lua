
local HomeBarLayer = import("..homeBar.HomeBarLayer")
local main = import("..start.StartLayer")
local LayerColor_BLACK = cc.c4b(0, 122, 44, 0)

local RootLayer = class("RootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function RootLayer:ctor()
	--instance

	--add res
    self:addResHome()
    -- self:addResFight()    
    self:initLoginLayer()


    --loading
    --todo

	--event
	cc.EventProxy.new(ui, self)
		:addEventListener(ui.LAYER_CHANGE_EVENT, handler(self, self.switchLayer))
end

function RootLayer:initLoginLayer()
    self.curLayer = main.new()
    self:removeAllChildren()
    self:addChild(self.curLayer)      
    self:addResFight()    
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
    cc.FileUtils:getInstance():addSearchPath("res/public")
    display.addSpriteFrames("allImg0.plist", "allImg0.png")
    display.addSpriteFrames("weaponicon0.plist", "weaponicon0.png")
    
    --armature
    
    --sound
    local startMusic = "res/Start/start.ogg"
    -- local homeBarMusic = "res/HomeBarLayer/homeBar.ogg"
    audio.preloadMusic(startMusic)
    -- audio.preloadMusic(homeBarMusic)
end

function RootLayer:addResFight()
    --sprite
    display.addSpriteFrames("res/Fight/public/public0.plist", "res/Fight/public/public0.png")
    --armature
    local manager = ccs.ArmatureDataManager:getInstance()
    local enemyImgs = {"anim_enemy_002", "jinzhanb", "zibaob", "boss01","boss02", "dunbing", 
        "sanbing01", "daodan", "zpbing", "tieqiu", "shouleib", "shoulei"}
 
    for i,v in ipairs(enemyImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, handler(self, self.dataLoaded))
    end

    local heroImgs = {"avatarhit", "blood1", "blood2","hjwq", "jijia", 
        "beizha_sl", "bls", "btqpg"}
    for i,v in ipairs(heroImgs) do
        local src = "res/Fight/heroAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
    end

    local mapImgs = {"zdmz_pt", "zdmz_di", "hjqmz",}
    for i,v in ipairs(mapImgs) do
        local src = "res/Fight/mapAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
    end

    local uiImgs = {"baotou", "huanzidan", "ruodiangj", "tanhao",
        "gold", "danke", "baozhasl_y", "xuetiao", "baozha4",
        "effect_gun_kaiqiang"}
    for i,v in ipairs(uiImgs) do
        local src = "res/Fight/uiAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
    end

    local jqkImgs = {"effect_gun_jqk", "qkzd", "pzqk","hjtqk", "syqk", "syqkzd", "hjtqkzd"} 
    for i,v in ipairs(jqkImgs) do
        local src = "res/Fight/jqkAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
    end 

    local focusImgs = {"sandq_zx", "huojt_zx", "anim_zunxin_sq", "jijia_zx"} 
    for i,v in ipairs(focusImgs) do
        local src = "res/Fight/focusAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
    end 

    local gunImgs = {"anim_ak", "anim_jfzc", "anim_lmd", "anim_m4", "anim_m134",
        "anim_mp5", "anim_rpg", "anim_sy"}
    for i,v in ipairs(gunImgs) do
        local src = "res/Fight/gunsAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
    end    

    local dizuosrc = "res/LevelMap/gktb/gktb.csb"
    manager:addArmatureFileInfoAsync(dizuosrc,  handler(self, self.dataLoaded))

    local inlaybtnsrc = "res/InlayShop/xqan_hjwq/xqan_hjwq.csb"
    manager:addArmatureFileInfoAsync(inlaybtnsrc,  handler(self, self.dataLoaded))

    --dd
    local mapsrc = "res/LevelMap/map_shijie/shijiemap.csb"
    manager:addArmatureFileInfoAsync(mapsrc,  handler(self, self.dataLoaded))
    
    local qdcxsrc = "res/public/Anim/qiangdicx/qiangdicx.csb"
    manager:addArmatureFileInfoAsync(qdcxsrc,  handler(self, self.dataLoaded))

    local rwkssrc = "res/public/Anim/renwuks/renwuks.csb"
    manager:addArmatureFileInfoAsync(rwkssrc,  handler(self, self.dataLoaded))

    local drlxsrc = "res/public/Anim/direnlx/direnlx.csb"
    manager:addArmatureFileInfoAsync(drlxsrc,  handler(self, self.dataLoaded))

    local bossjjsrc = "res/CommonPopup/animLayer/bossjj/bossjj.csb"
    manager:addArmatureFileInfoAsync(bossjjsrc,  handler(self, self.dataLoaded))

    local ydfhsrc = "res/FightResult/anim/ydfh/ydfh.csb"
    manager:addArmatureFileInfoAsync(ydfhsrc,  handler(self, self.dataLoaded))

    local hjwqbssrc = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs.csb"
    manager:addArmatureFileInfoAsync(hjwqbssrc,  handler(self, self.dataLoaded))

    local xqtbsrc = "res/InlayShop/xqtb/xqtb.csb"
    manager:addArmatureFileInfoAsync(xqtbsrc,  handler(self, self.dataLoaded))

    local xqzbsrc = "res/InlayShop/xqzb/xqzb.csb"
    manager:addArmatureFileInfoAsync(xqzbsrc,  handler(self, self.dataLoaded))

    self:addResFightMusic()
end

function RootLayer:addResFightMusic()
    -- local names = {}

end

function RootLayer:dataLoaded(percent)
    print(" dataLoaded() percent:"..percent)
    if percent == 1 then 
        -- self:initLoginLayer()
    end
end

return RootLayer