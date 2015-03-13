local StartLayer = import("..start.StartLayer")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local LayerColor_BLACK = cc.c4b(0, 122, 44, 0)

local RootLayer = class("RootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function RootLayer:ctor()
	--instance
    self.isLoadImage = false
    self.isLoadedArma = false

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
    if loadingType == "fight" or loadingType == "home" 
         or loadingType == "home_first" then 
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
    ui:showLoad(type)

    --clear
    self.isadded = false
    self:clearCache()

    --addcache
    self:addResPublic()

    if type == "home" or type == "home_first" then 
        self:addResHome()
    elseif type == "fight" then
        self:addResFight()
    end
end

function RootLayer:clearCache()
    display.removeUnusedSpriteFrames()
end

function RootLayer:addResPublic()
    display.addSpriteFrames("res/commonPNG/role0.plist", "res/commonPNG/role0.png", handler(self, self.imageLoaded)) 
    display.addSpriteFrames("res/commonPNG/item0.plist", "res/commonPNG/item0.png", handler(self, self.imageLoaded)) 
    display.addSpriteFrames("res/commonPNG/weaponicon0.plist", "res/commonPNG/weaponicon0.png", handler(self, self.imageLoaded))
end

function RootLayer:addResHome()
    -- display.removeUnusedSpriteFrames()
    --sprite
    print("function RootLayer:addResHome()")
    cc.FileUtils:getInstance():addSearchPath("res/commonPNG")
    --armature
    local manager = ccs.ArmatureDataManager:getInstance()

    local bossImgs = {
          "dzboss",
         "boss01", "boss01_1", "boss01_2", 
         "boss02", "boss02_1", "boss02_2",    
         "renzb", }
    for i,v in ipairs(bossImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, handler(self, self.dataLoaded)) 
        local plist = "res/Fight/enemys/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/enemys/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          
    end

    local mapsrc = "res/LevelMap/map_shijie/shijiemap.csb"
    manager:addArmatureFileInfoAsync(mapsrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/map_shijie/shijiemap0.plist"
    local png   = "res/LevelMap/map_shijie/shijiemap0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local tbtxsrc = "res/LevelMap/sjdt_tbtx/sjdt_tbtx.csb"
    manager:addArmatureFileInfoAsync(tbtxsrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/sjdt_tbtx/sjdt_tbtx0.plist"
    local png   = "res/LevelMap/sjdt_tbtx/sjdt_tbtx0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local inlaybtnsrc = "res/InlayShop/xqan_hjwq/xqan_hjwq.csb"
    manager:addArmatureFileInfoAsync(inlaybtnsrc,  handler(self, self.dataLoaded))
    local plist = "res/InlayShop/xqan_hjwq/xqan_hjwq0.plist"
    local png   = "res/InlayShop/xqan_hjwq/xqan_hjwq0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local hjwqbssrc = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs.csb"
    manager:addArmatureFileInfoAsync(hjwqbssrc,  handler(self, self.dataLoaded))
    local plist = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs0.plist"
    local png   = "res/InlayShop/xqan_hjwqbs/xqan_hjwqbs0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local xqtbsrc = "res/InlayShop/xqtb/xqtb.csb"
    manager:addArmatureFileInfoAsync(xqtbsrc,  handler(self, self.dataLoaded))
    local plist = "res/InlayShop/xqtb/xqtb0.plist"
    local png   = "res/InlayShop/xqtb/xqtb0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local xqzbsrc = "res/InlayShop/xqzb/xqzb.csb"
    manager:addArmatureFileInfoAsync(xqzbsrc,  handler(self, self.dataLoaded))
    local plist = "res/InlayShop/xqzb/xqzb0.plist"
    local png   = "res/InlayShop/xqzb/xqzb0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local wqsjsrc = "res/WeaponList/wqsj/wqsj.csb"
    manager:addArmatureFileInfoAsync(wqsjsrc,  handler(self, self.dataLoaded))
        local plist = "res/WeaponList/wqsj/wqsj0.plist"
    local png   = "res/WeaponList/wqsj/wqsj0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          


    local guangsrc = "res/Store/guang/guang.csb"
    manager:addArmatureFileInfoAsync(guangsrc,  handler(self, self.dataLoaded))
        local plist = "res/Store/guang/guang0.plist"
    local png   = "res/Store/guang/guang0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          


    local sczgsrc = "res/Store/sczg/sczg.csb"
    manager:addArmatureFileInfoAsync(sczgsrc,  handler(self, self.dataLoaded))
        local plist = "res/Store/sczg/sczg0.plist"
    local png   = "res/Store/sczg/sczg0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          


    local leidasrc = "res/LevelMap/leida/leida.csb"
    manager:addArmatureFileInfoAsync(leidasrc,  handler(self, self.dataLoaded))
        local plist = "res/LevelMap/leida/leida0.plist"
    local png   = "res/LevelMap/leida/leida0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          


    local jbsrc = "res/HomeBarLayer/jbs/jbs.csb"
    manager:addArmatureFileInfoAsync(jbsrc,  handler(self, self.dataLoaded))
        local plist = "res/HomeBarLayer/jbs/jbs0.plist"
    local png   = "res/HomeBarLayer/jbs/jbs0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          


    local zssrc = "res/HomeBarLayer/zss/zss.csb"
    manager:addArmatureFileInfoAsync(zssrc,  handler(self, self.dataLoaded))
        local plist = "res/HomeBarLayer/zss/zss0.plist"
    local png   = "res/HomeBarLayer/zss/zss0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          


    local mrdlsrc = "res/GiftBag/mrdl/mrdl.csb"
    manager:addArmatureFileInfoAsync(mrdlsrc,  handler(self, self.dataLoaded))
        local plist = "res/GiftBag/mrdl/mrdl0.plist"
    local png   = "res/GiftBag/mrdl/mrdl0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local yjzbsrc = "res/LevelDetail/btequipanim/bt_yjzb.csb"
    manager:addArmatureFileInfoAsync(yjzbsrc,  handler(self, self.dataLoaded))
        local plist = "res/LevelDetail/btequipanim/bt_yjzb0.plist"
    local png   = "res/LevelDetail/btequipanim/bt_yjzb0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          


    local thjbxsrc = "res/LevelMap/thj_bx/thj_bx.csb"
    manager:addArmatureFileInfoAsync(thjbxsrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/thj_bx/thj_bx0.plist"
    local png   = "res/LevelMap/thj_bx/thj_bx0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local libaosrc = "res/LevelMap/libao/libao.csb"
    manager:addArmatureFileInfoAsync(libaosrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/libao/libao0.plist"
    local png   = "res/LevelMap/libao/libao0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

end

function RootLayer:addResFight()
    cc.FileUtils:getInstance():addSearchPath("res/commonPNG")    
    display.addSpriteFrames("res/Fight/public/public0.plist", "res/Fight/public/public0.png", handler(self, self.imageLoaded))


    --sound effect
    local uiEffects = {"jijia_open.wav", "jijia_close.wav", "glass.wav", "gold.wav", "golds.wav", "hzd.wav", 
                "slbz.wav", "die.wav", "rengsl.wav", "plane.wav", "hithd.wav","beng.wav"}
 
    for i,v in ipairs(uiEffects) do
        local src = "res/Music/fight/"..uiEffects[i]
        audio.preloadSound(src)
    end    

    --armature
    local manager = ccs.ArmatureDataManager:getInstance()
    local enemyImgs = {
        --普通怪物
        "anim_enemy_002", "jinzhanb", "zibaob", "dunbing", 
        "qiqiu01", "qiqiu02", "qiqiu03", "xiaozz",
        "sanbing01", "zpbing", "shouleib",  "hs","feiji",
        "yyc","shangr","shangr_1", "xiaorz",  "feibiao","zzw",
        
        --导弹
        "shoulei", "daodan", "tieqiu", 
       

        -- --boss
        --  "dzboss",
        --  "boss01", "boss01_1", "boss01_2", 
        --  "boss02", "boss02_1", "boss02_2",    
        --  "renzb", 
    }
 
    for i,v in ipairs(enemyImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, handler(self, self.dataLoaded))
        local plist = "res/Fight/enemys/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/enemys/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))
    end

    local heroImgs = {"avatarhit", "blood1", "blood2","hjwq", "jijia", 
        "beizha_sl", "bls", "btqpg", "bossdies", "hjnlc", "ls"}
    for i,v in ipairs(heroImgs) do
        local src = "res/Fight/heroAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/heroAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/heroAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))        
    end

    local mapImgs = {"zdmz_pt", "zdmz_di", "hjqmz","dlhjak"}
    for i,v in ipairs(mapImgs) do
        local src = "res/Fight/mapAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/mapAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/mapAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))       
    end

    local uiImgs = {"baotou", "huanzidan", "ruodiangj", "tanhao",
        "gold", "danke", "baozhasl_y", "xuetiao", "baozha4",
        "effect_gun_kaiqiang", "wdhd"}
    for i,v in ipairs(uiImgs) do
        local src = "res/Fight/uiAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/uiAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/uiAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))         
    end

    local jqkImgs = {"effect_gun_jqk", "qkzd", "pzqk","hjtqk", "syqk", "syqkzd", "hjtqkzd"} 
    for i,v in ipairs(jqkImgs) do
        local src = "res/Fight/jqkAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/jqkAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/jqkAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          
    end 

    local focusImgs = {"sandq_zx", "huojt_zx", "anim_zunxin_sq", "jijia_zx"} 
    for i,v in ipairs(focusImgs) do
        local src = "res/Fight/focusAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/focusAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/focusAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))         
    end 

    local ydfhsrc = "res/FightResult/anim/ydfh/ydfh.csb"
    manager:addArmatureFileInfoAsync(ydfhsrc,  handler(self, self.dataLoaded))
    local plist = "res/FightResult/anim/ydfh/ydfh0.plist"
    local png   = "res/FightResult/anim/ydfh/ydfh0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          


    local rwkssrc = "res/Fight/uiAnim/renwuks/renwuks.csb"
    manager:addArmatureFileInfoAsync(rwkssrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/Fight/uiAnim/renwuks/renwuks0.plist", 
        "res/Fight/uiAnim/renwuks/renwuks0.png", handler(self, self.imageLoaded)) 

    local drlxsrc = "res/Fight/uiAnim/direnlx/direnlx.csb"
    manager:addArmatureFileInfoAsync(drlxsrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/Fight/uiAnim/direnlx/direnlx0.plist", 
        "res/Fight/uiAnim/direnlx/direnlx0.png", handler(self, self.imageLoaded)) 

    local bossjjsrc = "res/CommonPopup/animLayer/bossjj/bossjj.csb"
    manager:addArmatureFileInfoAsync(bossjjsrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/CommonPopup/animLayer/bossjj/bossjj0.plist", 
        "res/CommonPopup/animLayer/bossjj/bossjj0.png", handler(self, self.imageLoaded)) 

    local qdcxsrc = "res/Fight/uiAnim/qiangdicx/qiangdicx.csb"
    manager:addArmatureFileInfoAsync(qdcxsrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/Fight/uiAnim/qiangdicx/qiangdicx0.plist", 
        "res/Fight/uiAnim/qiangdicx/qiangdicx0.png", handler(self, self.imageLoaded))    

    local jinbijlsrc = "res/Fight/uiAnim/jinbijl/jinbijl.csb"
    manager:addArmatureFileInfoAsync(jinbijlsrc, handler(self, self.dataLoaded))
    display.addSpriteFrames("res/Fight/uiAnim/jinbijl/jinbijl0.plist", 
        "res/Fight/uiAnim/jinbijl/jinbijl0.png", handler(self, self.imageLoaded))    

    local ksxqsrc = "res/LevelDetail/bt_ksxq/bt_ksxq.csb"
    manager:addArmatureFileInfoAsync(ksxqsrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelDetail/bt_ksxq/bt_ksxq0.plist"
    local png   = "res/LevelDetail/bt_ksxq/bt_ksxq0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

   -- --music
   --  self:addResFightMusic()

    local gunImgs = {"anim_ak", "anim_jfzc", "anim_lmd", "anim_m4", "anim_m134",
        "anim_mp5", "anim_rpg", "anim_sy"}
    for i,v in ipairs(gunImgs) do
        local src = "res/Fight/gunsAnim/"..v.."/"..v..".csb"

        local plist = "res/Fight/gunsAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/gunsAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))  
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))                
    end

    local plist = "res/LevelMap/thj_bx/thj_bx0.plist"
    local png   = "res/LevelMap/thj_bx/thj_bx0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))     
end

function RootLayer:addResFightMusic()
    -- local names = {}
end

--sprite
function RootLayer:imageLoaded(plist, image)
    --todo 加个尾图 方便测试 例如ima ge == "res/ended.png"
    -- if image == "res/LevelMap/thj_bx/thj_bx0.png" then
    local lastImage
    if device.platform == "windows" or  device.platform == "mac" then 
        lastImage = "res/LevelMap/thj_bx/thj_bx0.png"
    else
        lastImage =  "res/thj_bx0.png"
    end
    if image == lastImage then
        self.isLoadImage  = true
        self:onloadDone()
    end
end

--armature
function RootLayer:dataLoaded(percent)
    -- print(" dataLoaded() percent:"..percent)
    if percent == 1 then
        if self.isLoadedArma then return end
        --clear load
        self.isLoadedArma = true 
        self:onloadDone()
        
    end
end

function RootLayer:onloadDone()
    if self.isLoadedArma and self.isLoadImage then 
        self.isLoadedArma = false
        self.isLoadImage  = false
        local p = self.waitLayerProperties
        self.curLayer = self.waitLayerCls.new(p)
        self:addChild(self.curLayer)
        local function hide()
            ui:hideLoad()
        end
        self:performWithDelay(hide, 0.5)
    end
end

return RootLayer