local StartLayer = import("..start.StartLayer")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local LayerColor_BLACK = cc.c4b(0, 122, 44, 0)

local RootLayer = class("RootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function RootLayer:ctor()
	--instance

	--add res 
    self:initLoginLayer()

	--event
	cc.EventProxy.new(ui, self)
		:addEventListener(ui.LAYER_CHANGE_EVENT, handler(self, self.switchLayer))
end

function RootLayer:initLoginLayer()
    self.curLayer = StartLayer.new()
    self:addChild(self.curLayer)      
end

function RootLayer:switchLayer(event)
	-- dump(event, "event")
    --clear
    self.curLayer:removeSelf()

    --add
    local loadingType = event.loadingType
    local layerCls   = event.layerCls
    local properties = event.properties
    if loadingType == "fight" or loadingType == "home" then 
        self.waitLayerCls        = layerCls
        self.waitLayerProperties = properties
        self:showLoadLayer(loadingType)
    else
    	self.curLayer = layerCls.new(properties)
    	self:addChild(self.curLayer)
    end
end

function RootLayer:showLoadLayer(type)
    print("function RootLayer:showLoadLayer(type)")
    ui:showLoad()

    --clear
    self.isadded = false
    self:clearCache()

    --addcache
    if type == "home" then 
        self:addResHome()
    elseif type == "fight" then
        self:addResFight()
    end
end

function RootLayer:clearCache()
    -- display.removeUnusedSpriteFrames()
end

function RootLayer:addResHome()
    --sprite
    print("function RootLayer:addResHome()")
    cc.FileUtils:getInstance():addSearchPath("res/public")
    display.addSpriteFrames("allImg0.plist", "allImg0.png")
    display.addSpriteFrames("weaponicon0.plist", "weaponicon0.png")
    
    --armature
    local manager = ccs.ArmatureDataManager:getInstance()

    local bossImgs = {"boss01","boss02",}
 
    for i,v in ipairs(bossImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, handler(self, self.dataLoaded))
    end

    local mapsrc = "res/LevelMap/map_shijie/shijiemap.csb"
    manager:addArmatureFileInfoAsync(mapsrc,  handler(self, self.dataLoaded))

    local dizuosrc = "res/LevelMap/gktb/gktb.csb"
    manager:addArmatureFileInfoAsync(dizuosrc,  handler(self, self.dataLoaded))

    local inlaybtnsrc = "res/InlayShop/xqan_hjwq/xqan_hjwq.csb"
    manager:addArmatureFileInfoAsync(inlaybtnsrc,  handler(self, self.dataLoaded))

    local ydfhsrc = "res/FightResult/anim/ydfh/ydfh.csb"
    manager:addArmatureFileInfoAsync(ydfhsrc,  handler(self, self.dataLoaded))

    local hjwqbssrc = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs.csb"
    manager:addArmatureFileInfoAsync(hjwqbssrc,  handler(self, self.dataLoaded))

    local xqtbsrc = "res/InlayShop/xqtb/xqtb.csb"
    manager:addArmatureFileInfoAsync(xqtbsrc,  handler(self, self.dataLoaded))

    local xqzbsrc = "res/InlayShop/xqzb/xqzb.csb"
    manager:addArmatureFileInfoAsync(xqzbsrc,  handler(self, self.dataLoaded))

    local wqsjsrc = "res/WeaponList/wqsj/wqsj.csb"
    manager:addArmatureFileInfoAsync(wqsjsrc,  handler(self, self.dataLoaded))

    local guangsrc = "res/Store/guang/guang.csb"
    manager:addArmatureFileInfoAsync(guangsrc,  handler(self, self.dataLoaded))

    local sczgsrc = "res/Store/sczg/sczg.csb"
    manager:addArmatureFileInfoAsync(sczgsrc,  handler(self, self.dataLoaded))

    local leidasrc = "res/LevelMap/leida/leida.csb"
    manager:addArmatureFileInfoAsync(leidasrc,  handler(self, self.dataLoaded))

    local jbsrc = "res/HomeBarLayer/jbs/jbs.csb"
    manager:addArmatureFileInfoAsync(jbsrc,  handler(self, self.dataLoaded))

    local zssrc = "res/HomeBarLayer/zss/zss.csb"
    manager:addArmatureFileInfoAsync(zssrc,  handler(self, self.dataLoaded))

    local mrdlsrc = "res/GiftBag/mrdl/mrdl.csb"
    manager:addArmatureFileInfoAsync(mrdlsrc,  handler(self, self.dataLoaded))

    --sound
    local startMusic = "res/Start/start.ogg"
    audio.preloadMusic(startMusic)
    -- local homeBarMusic = "res/HomeBarLayer/homeBar.ogg"
    -- audio.preloadMusic(homeBarMusic)


end

function RootLayer:addResFight()
    print("function RootLayer:addResFight()")
    --sprite
    display.addSpriteFrames("res/Fight/public/public0.plist", "res/Fight/public/public0.png")
    display.addSpriteFrames("weaponicon0.plist", "weaponicon0.png")
    -- local cb = function(plist, image)
    -- -- do something
    -- end
    -- display.addSpriteFrames("Sprites.plist", "Sprites.png", cb)    
    --armature
    local manager = ccs.ArmatureDataManager:getInstance()
    local enemyImgs = {"anim_enemy_002", "jinzhanb", "zibaob", "boss01","boss02", "dunbing", 
        "sanbing01", "daodan", "zpbing", "tieqiu", "shouleib", "shoulei", "hs","feiji","yyc",
        "renzb", "feibiao",
        "qiqiu01", "qiqiu02", "qiqiu03", "qiqiu04"}
 
    for i,v in ipairs(enemyImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, handler(self, self.dataLoaded))
        -- local plist = "res/Fight/enemys/"..v.."/"..v.."0.plist"
        -- local png   = "res/Fight/enemys/"..v.."/"..v.."0.plist"
        -- display.addSpriteFrames(plist, png)
        -- self:add
    end

    local heroImgs = {"avatarhit", "blood1", "blood2","hjwq", "jijia", 
        "beizha_sl", "bls", "btqpg", "bossdies"}
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
        "effect_gun_kaiqiang", "wdhd"}
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

    --todo
    local rwkssrc = "res/public/Anim/renwuks/renwuks.csb"
    manager:addArmatureFileInfoAsync(rwkssrc,  handler(self, self.dataLoaded))

    local drlxsrc = "res/public/Anim/direnlx/direnlx.csb"
    manager:addArmatureFileInfoAsync(drlxsrc,  handler(self, self.dataLoaded))

    local bossjjsrc = "res/CommonPopup/animLayer/bossjj/bossjj.csb"
    manager:addArmatureFileInfoAsync(bossjjsrc,  handler(self, self.dataLoaded))


    local qdcxsrc = "res/public/Anim/qiangdicx/qiangdicx.csb"
    manager:addArmatureFileInfoAsync(qdcxsrc,  handler(self, self.dataLoaded))
   

   --music
    self:addResFightMusic()
end

function RootLayer:addSpriteFrames()
    
end

function RootLayer:addResFightMusic()
    -- local names = {}

end

function RootLayer:dataLoaded(percent)
    -- print(" dataLoaded() percent:"..percent)
    if percent == 1 then
        if self.isadded then return end

        --clear load
        self:removeLoadDelay()
        --add dest layer
         self.isadded = true 
    end
end

function RootLayer:removeLoadDelay()
    local function callfunc ()
        ui:hideLoad()   
        -- print("ui:hideLoad()")   
    end

    local function callfuncAdd()
        local p = self.waitLayerProperties
        self.curLayer = self.waitLayerCls.new(p)
        self:addChild(self.curLayer)
    end
    scheduler.performWithDelayGlobal(callfunc, 2.5)
    scheduler.performWithDelayGlobal(callfuncAdd, 2.0)
end

return RootLayer