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
    -- display.removeUnusedSpriteFrames()
    --sprite
    print("function RootLayer:addResHome()")
    cc.FileUtils:getInstance():addSearchPath("res/public")
    local cb = function(plist, image)
       
    end
    display.addSpriteFrames("allImg0.plist", "allImg0.png" ,cb)
    display.addSpriteFrames("weaponicon0.plist", "weaponicon0.png" ,cb)
    --armature
    local manager = ccs.ArmatureDataManager:getInstance()

    local bossImgs = {"boss01","boss02","dzboss","renzb"}
 
    for i,v in ipairs(bossImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, handler(self, self.dataLoaded)) 
        local plist = "res/Fight/enemys/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/enemys/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, cb)          
    end

    local mapsrc = "res/LevelMap/map_shijie/shijiemap.csb"
    manager:addArmatureFileInfoAsync(mapsrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/map_shijie/shijiemap0.plist"
    local png   = "res/LevelMap/map_shijie/shijiemap0.png"
    display.addSpriteFrames(plist, png, cb)          

    local dizuosrc = "res/LevelMap/gktb/gktb.csb"
    manager:addArmatureFileInfoAsync(dizuosrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/gktb/gktb0.plist"
    local png   = "res/LevelMap/gktb/gktb0.png"
    display.addSpriteFrames(plist, png, cb)          

    local inlaybtnsrc = "res/InlayShop/xqan_hjwq/xqan_hjwq.csb"
    manager:addArmatureFileInfoAsync(inlaybtnsrc,  handler(self, self.dataLoaded))
    local plist = "res/InlayShop/xqan_hjwq/xqan_hjwq0.plist"
    local png   = "res/InlayShop/xqan_hjwq/xqan_hjwq0.png"
    display.addSpriteFrames(plist, png, cb)          

    local ydfhsrc = "res/FightResult/anim/ydfh/ydfh.csb"
    manager:addArmatureFileInfoAsync(ydfhsrc,  handler(self, self.dataLoaded))
    local plist = "res/FightResult/anim/ydfh/ydfh0.plist"
    local png   = "res/FightResult/anim/ydfh/ydfh0.png"
    display.addSpriteFrames(plist, png, cb)          

    local hjwqbssrc = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs.csb"
    manager:addArmatureFileInfoAsync(hjwqbssrc,  handler(self, self.dataLoaded))
    local plist = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs0.plist"
    local png   = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs0.png"
    display.addSpriteFrames(plist, png, cb)          

    local xqtbsrc = "res/InlayShop/xqtb/xqtb.csb"
    manager:addArmatureFileInfoAsync(xqtbsrc,  handler(self, self.dataLoaded))
    local plist = "res/InlayShop/xqtb/xqtb0.plist"
    local png   = "res/InlayShop/xqtb/xqtb0.png"
    display.addSpriteFrames(plist, png, cb)          

    local xqzbsrc = "res/InlayShop/xqzb/xqzb.csb"
    manager:addArmatureFileInfoAsync(xqzbsrc,  handler(self, self.dataLoaded))
    local plist = "res/InlayShop/xqzb/xqzb0.plist"
    local png   = "res/InlayShop/xqzb/xqzb0.png"
    display.addSpriteFrames(plist, png, cb)          

    local wqsjsrc = "res/WeaponList/wqsj/wqsj.csb"
    manager:addArmatureFileInfoAsync(wqsjsrc,  handler(self, self.dataLoaded))
        local plist = "res/WeaponList/wqsj/wqsj0.plist"
    local png   = "res/WeaponList/wqsj/wqsj0.png"
    display.addSpriteFrames(plist, png, cb)          


    local guangsrc = "res/Store/guang/guang.csb"
    manager:addArmatureFileInfoAsync(guangsrc,  handler(self, self.dataLoaded))
        local plist = "res/Store/guang/guang0.plist"
    local png   = "res/Store/guang/guang0.png"
    display.addSpriteFrames(plist, png, cb)          


    local sczgsrc = "res/Store/sczg/sczg.csb"
    manager:addArmatureFileInfoAsync(sczgsrc,  handler(self, self.dataLoaded))
        local plist = "res/Store/sczg/sczg0.plist"
    local png   = "res/Store/sczg/sczg0.png"
    display.addSpriteFrames(plist, png, cb)          


    local leidasrc = "res/LevelMap/leida/leida.csb"
    manager:addArmatureFileInfoAsync(leidasrc,  handler(self, self.dataLoaded))
        local plist = "res/LevelMap/leida/leida0.plist"
    local png   = "res/LevelMap/leida/leida0.png"
    display.addSpriteFrames(plist, png, cb)          


    local jbsrc = "res/HomeBarLayer/jbs/jbs.csb"
    manager:addArmatureFileInfoAsync(jbsrc,  handler(self, self.dataLoaded))
        local plist = "res/HomeBarLayer/jbs/jbs0.plist"
    local png   = "res/HomeBarLayer/jbs/jbs0.png"
    display.addSpriteFrames(plist, png, cb)          


    local zssrc = "res/HomeBarLayer/zss/zss.csb"
    manager:addArmatureFileInfoAsync(zssrc,  handler(self, self.dataLoaded))
        local plist = "res/HomeBarLayer/zss/zss0.plist"
    local png   = "res/HomeBarLayer/zss/zss0.png"
    display.addSpriteFrames(plist, png, cb)          


    local mrdlsrc = "res/GiftBag/mrdl/mrdl.csb"
    manager:addArmatureFileInfoAsync(mrdlsrc,  handler(self, self.dataLoaded))
        local plist = "res/GiftBag/mrdl/mrdl0.plist"
    local png   = "res/GiftBag/mrdl/mrdl0.png"
    display.addSpriteFrames(plist, png, cb)          


    local yjzbsrc = "res/LevelDetail/btequipanim/bt_yjzb.csb"
    manager:addArmatureFileInfoAsync(yjzbsrc,  handler(self, self.dataLoaded))
        local plist = "res/LevelDetail/btequipanim/bt_yjzb0.plist"
    local png   = "res/LevelDetail/btequipanim/bt_yjzb0.png"
    display.addSpriteFrames(plist, png, cb)          


    local thjbxsrc = "res/LevelMap/thj_bx/thj_bx.csb"
    manager:addArmatureFileInfoAsync(thjbxsrc,  handler(self, self.dataLoaded))
        local plist = "res/LevelMap/thj_bx/thj_bx0.plist"
    local png   = "res/LevelMap/thj_bx/thj_bx0.png"
    display.addSpriteFrames(plist, png, cb)          


    --music bg
    local startMusic = "res/Music/bg/bjyx.wav"
    audio.preloadMusic(startMusic)

    --sound ui
    local uiEffects = {"rwwc.wav", "dianji.wav", "letsgo.wav", "gmcg.wav",
                     "wqsj.wav", "xqcg.wav", "zx.wav"}
 
    for i,v in ipairs(uiEffects) do
        local src = "res/Music/ui/"..uiEffects[i]
        audio.preloadSound(src)
    end
end

function RootLayer:addResFight()
    -- display.removeUnusedSpriteFrames()
    print("function RootLayer:addResFight()")
    --sprite
    local cb = function(plist, image)
       
    end    
    cc.FileUtils:getInstance():addSearchPath("res/public")    
    display.addSpriteFrames("allImg0.plist", "allImg0.png", cb ) 
    display.addSpriteFrames("role0.plist", "role0.png" ,cb)   
    display.addSpriteFrames("res/Fight/public/public0.plist", "res/Fight/public/public0.png", cb)
    display.addSpriteFrames("weaponicon0.plist", "weaponicon0.png", cb)

    local musics = {"bj_zhandou.wav"}
    for i,v in ipairs(musics) do
        local src = "res/Music/fight/"..musics[i]
        audio.preloadMusic(src)
    end

    --sound weapon
    local weaponEffects = {"lmdfire.wav", "mp5fire.wav", "syfire.wav", "ak47fire.wav", "m4fire.wav", "rpgfire.wav", 
                "m134fire.wav", "jfzcfire.wav"}
 
    for i,v in ipairs(weaponEffects) do
        local src = "res/Music/weapon/"..weaponEffects[i]
        audio.preloadSound(src)
    end

    --sound effect
    local uiEffects = {"jijia_open.wav", "jijia_close.wav", "glass.wav", "gold.wav", "golds.wav", "hzd.wav", 
                "slbz.wav", "die.wav", "rengsl.wav", "plane.wav", "hithd.wav","beng.wav"}
 
    for i,v in ipairs(uiEffects) do
        local src = "res/Music/fight/"..uiEffects[i]
        audio.preloadSound(src)
    end    

    --armature
    local manager = ccs.ArmatureDataManager:getInstance()
    local enemyImgs = {"anim_enemy_002", "jinzhanb", "zibaob", "boss01","boss02", "dunbing", 
        "sanbing01", "daodan", "zpbing", "tieqiu", "shouleib", "shoulei", "hs","feiji","yyc",
        "renzb", "feibiao","dzboss","zzw",
        "qiqiu01", "qiqiu02", "qiqiu03", "qiqiu04"}
 
    for i,v in ipairs(enemyImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, handler(self, self.dataLoaded))
        local plist = "res/Fight/enemys/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/enemys/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, cb)
    end

    local heroImgs = {"avatarhit", "blood1", "blood2","hjwq", "jijia", 
        "beizha_sl", "bls", "btqpg", "bossdies", "hjnlc"}
    for i,v in ipairs(heroImgs) do
        local src = "res/Fight/heroAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/heroAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/heroAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, cb)        
    end

    local mapImgs = {"zdmz_pt", "zdmz_di", "hjqmz",}
    for i,v in ipairs(mapImgs) do
        local src = "res/Fight/mapAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/mapAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/mapAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, cb)       
    end

    local uiImgs = {"baotou", "huanzidan", "ruodiangj", "tanhao",
        "gold", "danke", "baozhasl_y", "xuetiao", "baozha4",
        "effect_gun_kaiqiang", "wdhd"}
    for i,v in ipairs(uiImgs) do
        local src = "res/Fight/uiAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/uiAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/uiAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, cb)         
    end

    local jqkImgs = {"effect_gun_jqk", "qkzd", "pzqk","hjtqk", "syqk", "syqkzd", "hjtqkzd"} 
    for i,v in ipairs(jqkImgs) do
        local src = "res/Fight/jqkAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/jqkAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/jqkAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, cb)          
    end 

    local focusImgs = {"sandq_zx", "huojt_zx", "anim_zunxin_sq", "jijia_zx"} 
    for i,v in ipairs(focusImgs) do
        local src = "res/Fight/focusAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/focusAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/focusAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, cb)         
    end 

    local gunImgs = {"anim_ak", "anim_jfzc", "anim_lmd", "anim_m4", "anim_m134",
        "anim_mp5", "anim_rpg", "anim_sy"}
    for i,v in ipairs(gunImgs) do
        local src = "res/Fight/gunsAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/gunsAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/gunsAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, cb)          
    end    

    local rwkssrc = "res/public/Anim/renwuks/renwuks.csb"
    manager:addArmatureFileInfoAsync(rwkssrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/public/Anim/renwuks/renwuks0.plist", 
        "res/public/Anim/renwuks/renwuks0.png", cb) 

    local drlxsrc = "res/public/Anim/direnlx/direnlx.csb"
    manager:addArmatureFileInfoAsync(drlxsrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/public/Anim/direnlx/direnlx0.plist", 
        "res/public/Anim/direnlx/direnlx0.png", cb) 

    local bossjjsrc = "res/CommonPopup/animLayer/bossjj/bossjj.csb"
    manager:addArmatureFileInfoAsync(bossjjsrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/CommonPopup/animLayer/bossjj/bossjj0.plist", 
        "res/CommonPopup/animLayer/bossjj/bossjj0.png", cb) 

    local qdcxsrc = "res/public/Anim/qiangdicx/qiangdicx.csb"
    manager:addArmatureFileInfoAsync(qdcxsrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/public/Anim/qiangdicx/qiangdicx0.plist", 
        "res/public/Anim/qiangdicx/qiangdicx0.png", cb)    

   --music
    self:addResFightMusic()
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