local StartLayer = import("..start.StartLayer")
local FightPlayer = import("..fight.FightPlayer")

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
    self:addFrameRes("res/commonPNG/role0.plist", "res/commonPNG/role0.png") 
    self:addFrameRes("res/commonPNG/item0.plist", "res/commonPNG/item0.png") 
    self:addFrameRes("res/commonPNG/weaponicon0.plist", "res/commonPNG/weaponicon0.png")
end

function RootLayer:addResHome()
    -- display.removeUnusedSpriteFrames()
    --sprite
    print("function RootLayer:addResHome()")
    cc.FileUtils:getInstance():addSearchPath("res/commonPNG")
    --armature
    local manager = ccs.ArmatureDataManager:getInstance()

    local mapsrc = "res/LevelMap/shijiemap/shijiemap.ExportJson"
    self:addArmatureRes(mapsrc)

    local tbtxsrc = "res/LevelMap/sjdt_tbtx/sjdt_tbtx.ExportJson"
    self:addArmatureRes(tbtxsrc)
    local plist = "res/LevelMap/sjdt_tbtx/sjdt_tbtx0.plist"
    local png   = "res/LevelMap/sjdt_tbtx/sjdt_tbtx0.png"
    self:addFrameRes(plist, png)

    local guangsrc = "res/Store/guang/guang.ExportJson"
    self:addArmatureRes(guangsrc)
    local plist = "res/Store/guang/guang0.plist"
    local png   = "res/Store/guang/guang0.png"
    self:addFrameRes(plist, png)          

    local sczgsrc = "res/Store/sczg/sczg.ExportJson"
    self:addArmatureRes(sczgsrc)
    local plist = "res/Store/sczg/sczg0.plist"
    local png   = "res/Store/sczg/sczg0.png"
    self:addFrameRes(plist, png)          

    local leidasrc = "res/LevelMap/leida/leida.ExportJson"
    self:addArmatureRes(leidasrc)
    local plist = "res/LevelMap/leida/leida0.plist"
    local png   = "res/LevelMap/leida/leida0.png"
    self:addFrameRes(plist, png)          

    local jbsrc = "res/HomeBarLayer/jbs/jbs.ExportJson"
    self:addArmatureRes(jbsrc)
    local plist = "res/HomeBarLayer/jbs/jbs0.plist"
    local png   = "res/HomeBarLayer/jbs/jbs0.png"
    self:addFrameRes(plist, png)          

    local zssrc = "res/HomeBarLayer/zss/zss.ExportJson"
    self:addArmatureRes(zssrc)
    local plist = "res/HomeBarLayer/zss/zss0.plist"
    local png   = "res/HomeBarLayer/zss/zss0.png"
    self:addFrameRes(plist, png)          

    local libaosrc = "res/LevelMap/libao/libao.ExportJson"
    self:addArmatureRes(libaosrc)
    local plist = "res/LevelMap/libao/libao0.plist"
    local png   = "res/LevelMap/libao/libao0.png"
    self:addFrameRes(plist, png)          

    local yjzbsrc = "res/LevelDetail/btequipanim/bt_yjzb.ExportJson"
    self:addArmatureRes(yjzbsrc)
    local plist = "res/LevelDetail/btequipanim/bt_yjzb0.plist"
    local png   = "res/LevelDetail/btequipanim/bt_yjzb0.png"
    self:addFrameRes(plist, png)

    local thjbxsrc = "res/LevelMap/thj_bx/thj_bx.ExportJson"
    self:addArmatureRes(thjbxsrc)
    local plist = "res/LevelMap/thj_bx/thj_bx0.plist"
    local png   = "res/LevelMap/thj_bx/thj_bx0.png"
    self:addFrameRes(plist, png) 

    --
    self:onloadDone()
end

function RootLayer:addResFight() 
    local gid, lid = self.waitLayerProperties["groupId"], self.waitLayerProperties["levelId"]

    self:addFrameRes("res/Fight/public/public0.plist", "res/Fight/public/public0.png")  

    --armature
    local manager = ccs.ArmatureDataManager:getInstance()

    --enemys
    local fightConfigs  = md:getInstance("FightConfigs")
    local enemyImages = fightConfigs:getWaveImages(gid, lid)
    for i,v in ipairs(enemyImages) do
        local src = "res/Fight/enemys/"..v.."/"..v..".ExportJson"
        self:addArmatureRes(src)
        local plist = "res/Fight/enemys/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/enemys/"..v.."/"..v.."0.png"
        self:addFrameRes(plist, png)        
    end    

    local heroImgs = {"baotou","avatarhit", "blood1", "blood2","hjwq", "jijia", 
        "beizha_sl", "bls", "btqpg", "bossdies", "hjnlc", "ls", "yw", "tishi"}
    for i,v in ipairs(heroImgs) do
        local src = "res/Fight/heroAnim/"..v.."/"..v..".ExportJson"
        self:addArmatureRes(src)
        local plist = "res/Fight/heroAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/heroAnim/"..v.."/"..v.."0.png"
        self:addFrameRes(plist, png)        
    end

    local mapImgs = {"zdmz_pt", "zdmz_di", "hjqmz","dlhjak", "difang_dandao"}
    for i,v in ipairs(mapImgs) do
        local src = "res/Fight/mapAnim/"..v.."/"..v..".ExportJson"
        self:addArmatureRes(src)
        local plist = "res/Fight/mapAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/mapAnim/"..v.."/"..v.."0.png"
        self:addFrameRes(plist, png)       
    end

    local uiImgs = { "huanzidan", "ruodiangj", "tanhao",
        "gold", "danke", "baozhasl_y", "baozha4",
        "effect_gun_kaiqiang", "wdhd", 
        "direnlx", "renwuks", "qiangdicx", "jinbijl", "jiaxue"}
    for i,v in ipairs(uiImgs) do
        local src = "res/Fight/uiAnim/"..v.."/"..v..".ExportJson"
        self:addArmatureRes(src)
        local plist = "res/Fight/uiAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/uiAnim/"..v.."/"..v.."0.png"
        self:addFrameRes(plist, png)         
    end

    local jqkImgs = {"effect_gun_jqk", "qkzd", "pzqk","hjtqk", "syqk", "syqkzd", "hjtqkzd"} 
    for i,v in ipairs(jqkImgs) do
        local src = "res/Fight/jqkAnim/"..v.."/"..v..".ExportJson"
        self:addArmatureRes(src)
        local plist = "res/Fight/jqkAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/jqkAnim/"..v.."/"..v.."0.png"
        self:addFrameRes(plist, png)
    end

    local focusImgs = {"sandq_zx", "huojt_zx", "anim_zunxin_sq", "jijia_zx", "jiatl_zx"} 
    for i,v in ipairs(focusImgs) do
        local src = "res/Fight/focusAnim/"..v.."/"..v..".ExportJson"
        self:addArmatureRes(src)
        local plist = "res/Fight/focusAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/focusAnim/"..v.."/"..v.."0.png"
        self:addFrameRes(plist, png)         
    end 

    
    local bossjjsrc = "res/CommonPopup/animLayer/bossjj/bossjj.ExportJson"
    self:addArmatureRes(bossjjsrc)
    self:addFrameRes("res/CommonPopup/animLayer/bossjj/bossjj0.plist", 
        "res/CommonPopup/animLayer/bossjj/bossjj0.png") 

    local plist = "res/LevelMap/thj_bx/thj_bx0.plist"
    local png   = "res/LevelMap/thj_bx/thj_bx0.png"
    self:addFrameRes(plist, png)     
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

function RootLayer:addArmatureRes(src)
    local manager = ccs.ArmatureDataManager:getInstance()
    if isAsync then
        manager:addArmatureFileInfoAsync(src,handler(self, self.dataLoaded))
    else
        manager:addArmatureFileInfo(src)
    end
end

function RootLayer:addFrameRes(plist,png)
    if isAsync then
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))
    else
        display.addSpriteFrames(plist, png)

        local lastImage = "res/LevelMap/thj_bx/thj_bx0.png"        
        if png == lastImage then
            self.isLoadImage  = true
            self.isLoadedArma = true 
            self:onloadDone()
        end
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
        self:performWithDelay(hide, 2)
    end
end

return RootLayer