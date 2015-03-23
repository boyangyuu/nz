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

    local mapsrc = "res/LevelMap/shijiemap/shijiemap.ExportJson"
    manager:addArmatureFileInfoAsync(mapsrc,  handler(self, self.dataLoaded))

    local tbtxsrc = "res/LevelMap/sjdt_tbtx/sjdt_tbtx.ExportJson"
    manager:addArmatureFileInfoAsync(tbtxsrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/sjdt_tbtx/sjdt_tbtx0.plist"
    local png   = "res/LevelMap/sjdt_tbtx/sjdt_tbtx0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))

    local guangsrc = "res/Store/guang/guang.ExportJson"
    manager:addArmatureFileInfoAsync(guangsrc,  handler(self, self.dataLoaded))
    local plist = "res/Store/guang/guang0.plist"
    local png   = "res/Store/guang/guang0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local sczgsrc = "res/Store/sczg/sczg.ExportJson"
    manager:addArmatureFileInfoAsync(sczgsrc,  handler(self, self.dataLoaded))
    local plist = "res/Store/sczg/sczg0.plist"
    local png   = "res/Store/sczg/sczg0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local leidasrc = "res/LevelMap/leida/leida.ExportJson"
    manager:addArmatureFileInfoAsync(leidasrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/leida/leida0.plist"
    local png   = "res/LevelMap/leida/leida0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local jbsrc = "res/HomeBarLayer/jbs/jbs.ExportJson"
    manager:addArmatureFileInfoAsync(jbsrc,  handler(self, self.dataLoaded))
    local plist = "res/HomeBarLayer/jbs/jbs0.plist"
    local png   = "res/HomeBarLayer/jbs/jbs0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local zssrc = "res/HomeBarLayer/zss/zss.ExportJson"
    manager:addArmatureFileInfoAsync(zssrc,  handler(self, self.dataLoaded))
    local plist = "res/HomeBarLayer/zss/zss0.plist"
    local png   = "res/HomeBarLayer/zss/zss0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local libaosrc = "res/LevelMap/libao/libao.ExportJson"
    manager:addArmatureFileInfoAsync(libaosrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/libao/libao0.plist"
    local png   = "res/LevelMap/libao/libao0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          

    local thjbxsrc = "res/LevelMap/thj_bx/thj_bx.ExportJson"
    manager:addArmatureFileInfoAsync(thjbxsrc,  handler(self, self.dataLoaded))
    local plist = "res/LevelMap/thj_bx/thj_bx0.plist"
    local png   = "res/LevelMap/thj_bx/thj_bx0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          
end

function RootLayer:addResFight()
    cc.FileUtils:getInstance():addSearchPath("res/commonPNG")    
    display.addSpriteFrames("res/Fight/public/public0.plist", "res/Fight/public/public0.png", 
        handler(self, self.imageLoaded))  

    --armature
    local manager = ccs.ArmatureDataManager:getInstance()
    local enemyImgs = {
        --普通怪物
        "anim_enemy_002", "jinzhanb", "zibaob", "dunbing", 
        "qiqiu01", "qiqiu02", "qiqiu03", "xiaozz",
        "sanbing01", "zpbing", "shouleib",  "hs","feiji",
        "yyc","shangr","shangr_1", "xiaorz",  "feibiao","zzw",
        "dl_xz",
        --导弹
        "shoulei", "daodan", "tieqiu", "daodan02",
    }
    for i,v in ipairs(enemyImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, handler(self, self.dataLoaded))
        local plist = "res/Fight/enemys/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/enemys/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))
    end

    local heroImgs = {"baotou","avatarhit", "blood1", "blood2","hjwq", "jijia", 
        "beizha_sl", "bls", "btqpg", "bossdies", "hjnlc", "ls", "yw"}
    for i,v in ipairs(heroImgs) do
        local src = "res/Fight/heroAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/heroAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/heroAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))        
    end

    local mapImgs = {"zdmz_pt", "zdmz_di", "hjqmz","dlhjak", "dandao"}
    for i,v in ipairs(mapImgs) do
        local src = "res/Fight/mapAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/mapAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/mapAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))       
    end

    local uiImgs = { "huanzidan", "ruodiangj", "tanhao",
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

    local focusImgs = {"sandq_zx", "huojt_zx", "anim_zunxin_sq", "jijia_zx", "jiatl_zx"} 
    for i,v in ipairs(focusImgs) do
        local src = "res/Fight/focusAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src,  handler(self, self.dataLoaded))
        local plist = "res/Fight/focusAnim/"..v.."/"..v.."0.plist"
        local png   = "res/Fight/focusAnim/"..v.."/"..v.."0.png"
        display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))         
    end 

    local ydfhsrc = "res/FightResult/anim/ydfh/ydfh.ExportJson"
    manager:addArmatureFileInfoAsync(ydfhsrc,  handler(self, self.dataLoaded))
    local plist = "res/FightResult/anim/ydfh/ydfh0.plist"
    local png   = "res/FightResult/anim/ydfh/ydfh0.png"
    display.addSpriteFrames(plist, png, handler(self, self.imageLoaded))          


    local rwkssrc = "res/Fight/uiAnim/renwuks/renwuks.csb"
    manager:addArmatureFileInfoAsync(rwkssrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/Fight/uiAnim/renwuks/renwuks0.plist", 
        "res/Fight/uiAnim/renwuks/renwuks0.png", handler(self, self.imageLoaded)) 

    local drlxsrc = "res/Fight/uiAnim/direnlx/direnlx.ExportJson"
    manager:addArmatureFileInfoAsync(drlxsrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/Fight/uiAnim/direnlx/direnlx0.plist", 
        "res/Fight/uiAnim/direnlx/direnlx0.png", handler(self, self.imageLoaded)) 

    local bossjjsrc = "res/CommonPopup/animLayer/bossjj/bossjj.ExportJson"
    manager:addArmatureFileInfoAsync(bossjjsrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/CommonPopup/animLayer/bossjj/bossjj0.plist", 
        "res/CommonPopup/animLayer/bossjj/bossjj0.png", handler(self, self.imageLoaded)) 

    local qdcxsrc = "res/Fight/uiAnim/qiangdicx/qiangdicx.csb"
    manager:addArmatureFileInfoAsync(qdcxsrc,  handler(self, self.dataLoaded))
    display.addSpriteFrames("res/Fight/uiAnim/qiangdicx/qiangdicx0.plist", 
        "res/Fight/uiAnim/qiangdicx/qiangdicx0.png", handler(self, self.imageLoaded))    

    local jinbijlsrc = "res/Fight/uiAnim/jinbijl/jinbijl.ExportJson"
    manager:addArmatureFileInfoAsync(jinbijlsrc, handler(self, self.dataLoaded))
    display.addSpriteFrames("res/Fight/uiAnim/jinbijl/jinbijl0.plist", 
        "res/Fight/uiAnim/jinbijl/jinbijl0.png", handler(self, self.imageLoaded))    

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