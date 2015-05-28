

---- View ----
-- add button event listener
function playSoundBtn()
    local dianji = "res/Music/ui/button.wav"
    audio.playSound(dianji,false)
end

function addBtnEventListener(node, callfunc)
    assert(node, "node is invalid")
    assert(callfunc, "callfunc is invalid")
    node:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)        
        if event.name=='began' then
            -- cc.ColorUtil:isHighLighted(node, true)
            node:runAction(cc.ScaleTo:create(0.05, 1.1))
            local dianji = "res/Music/ui/button.wav"
            audio.playSound(dianji,false)
        elseif event.name=='ended' then
            -- cc.ColorUtil:isHighLighted(node, false)        
            node:runAction(cc.ScaleTo:create(0.1, 1))
        end
        local isAccepted = callfunc(event)
        return isAccepted
    end)
end

-- Cooldown the button
function disableBtn(delayTime, node)
    assert(delayTime, "delayTime is invalid")
    assert(node, "node is invalid")
    node:setTouchEnabled(false)
    node:runAction(transition.sequence({cc.DelayTime:create(delayTime), cc.CallFunc:create(function()
                 node:setTouchEnabled(true)
            end)}))
end

function getArmature(name, src)
    cc.FileUtils:getInstance():addSearchPath(src)
    assert(name, "name is invalid")
    assert(src, "src is invalid")
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    local armature = ccs.Armature:create(name) 
    return armature
end

function addChildCenter(child, parent, zorder)
    child:setPosition(parent:getBoundingBox().width/2, parent:getBoundingBox().height/2)
    child:setAnchorPoint(0.5, 0.5)
    if zorder then 
        parent:addChild(child, zorder)
    else 
        parent:addChild(child)
    end
end

function drawBoundingBox(parent, target, color)
    if  not isTest then return end
    if parent == nil then parent = target:getParent() end
    local cbb = target:getBoundingBox()
    -- dump(cbb, "cbb")
    local left, bottom, width, height = cbb.x, cbb.y, cbb.width, cbb.height
    local points = {
        {left, bottom},
        {left + width, bottom},
        {left + width, bottom + height},
        {left, bottom + height},
        {left, bottom},
    }
    if type(color) == "string" then 
        if color == "red" or nil then color =  cc.c4f(1.0, 0.0, 0, 1.0) 
        elseif color == "yellow" then color = cc.c4f(1.0, 1.0, 0, 1.0) 
        elseif color == "white" then color = cc.c4f(1.0, 1.0, 0, 1.0)  
        else 
        end
    end
    local box = display.newPolygon(points, {borderColor = color})
    parent:addChild(box, 1000)
end


---- Data ----
function getConfig( configFileDir )
    assert(configFileDir ~= "" and type(configFileDir) == "string", "invalid param")
    local fileUtil = cc.FileUtils:getInstance()
    local fullPath = fileUtil:fullPathForFilename(configFileDir)
    local jsonStr = fileUtil:getStringFromFile(fullPath)
    local decodeJsonStr = crypto.decodeBase64(jsonStr)
    local configTb = json.decode(decodeJsonStr)
    assert(configTb, "config is nil , name:"..configFileDir)
    return configTb
end

-- 通过表ID获取res下json文件内容
function getRecordByID( configFileDir, tableID)
    tableID = tonumber(tableID)
    assert(tableID ~= "" and type(tableID) == "number", 
        "invalid tableID configFileDir:"..configFileDir)

    local configTable = getConfig(configFileDir)
    for k,v in pairs(configTable) do
        if v["id"] == tableID then
            -- dump(v)
            return v
        end
    end
    print("not found, tableID is "..tableID)
    return nil
end

--[[
   @param 某列属性(PropertyName)查找在表(Table)中对应的(key)的记录
   @return 返回多条记录在数组中(recordArr)
]]
function getRecordByKey(configFileDir, propertyName, key)
    local table = getConfig(configFileDir) 
    assert(propertyName ~= "" and type(propertyName) == "string", "invalid param")
    assert(key ~= "", "key is invalid param")
    -- key = tostring(key)
    local recordArr={}
    for k,v in pairs(table) do
        for k1,v1 in pairs(v) do
            if k1 == propertyName and v1 == key then
                recordArr[#recordArr + 1] = v
            end
        end
    end
    return recordArr
end

--[[
    example: local records = getRecordFromTable(xx, )
    
]]

function getRecordFromTable(table, propertyName, key)
    assert(propertyName ~= "" and type(propertyName) == "string", "invalid param")
    assert(key ~= "", "key is invalid param")
    local recordArr={}
    for k,v in pairs(table) do
        for k1,v1 in pairs(v) do
            if k1 == propertyName and v1 == key then
                recordArr[#recordArr + 1] = v
            end
        end
    end
    return recordArr
end


function getUserData()
    return GameData
end

function setUserData(data)
    GameState.save(data)
end

function removeAllItems(listView)
    local itemsNum_ = table.nums(listView.items_)
    for i=1,itemsNum_ do
        listView:removeItem(listView.items_[1],false)
    end
    return listView
end

function addBtnEffect(btn)
    local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
    btn:setBlendFunc(cc.BLEND_SRC, cc.BLEND_SRC) 
    btn:scaleTo(0.05, 1.1)
    local sch
    local function restore()
        btn:setBlendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA)
        btn:scaleTo(0.05, 1)
        scheduler.unscheduleGlobal(sch)
    end
    
    sch = scheduler.performWithDelayGlobal(restore, 0.1)   
end


function isDefendMM()
    local endYear = 2016
    local endMonth = 4
    local endDay = 25

    local time = os.time()
    local year  = tonumber(os.date("%Y", time))
    local month = tonumber(os.date("%m", time))
    local day   = tonumber(os.date("%d", time))

    if year < endYear then
        return true
    elseif year > endYear then
        return false
    else
        if month < endMonth then
            return true
        elseif month > endMonth then
            return false
        else 
            if day <= endDay then
                return true
            else
                return false
            end
        end
    end
end

function isDefendDX()
    if getIapName() == "telecom" then
        return true
    else
        return false
    end
end
                               
function getIapType()   -- "confirm", "noIap", "noConfirm"
    if device.platform ~= 'android' then return true end
    local className = "com/hgtt/com/IAPControl"
    local methodName = "getIapType"
    local args = {}
    local sig = "()Ljava/lang/String;"
    local iapType = nil
    local luajResult = nil
    luajResult, iapType = luaj.callStaticMethod(className, methodName, args, sig)
    print("luajResult:", luajResult)
    print("iapType:", iapType)
    if luajResult then
        return iapType
    end
    return "confirm"
end

function getIapName()
    local iapName = 'unknown'
    if device.platform == 'android' then
        local result,iapName = luaj.callStaticMethod("com/hgtt/com/IAPControl", "getIapName", {}, "()Ljava/lang/String;")
        return iapName
    end
    print("iapName:",iapName)
    return iapName
end



-- function isMobileSimCard()
--     if device.platform ~= 'android' then return true, 1 end
--     local result,iapName = luaj.callStaticMethod("com/hgtt/com/IAPControl", "getIapName", {}, "()Ljava/lang/String;")

--     if iapName == nil then return true, 1 end

--     if iapName == 'mm' or iapName == 'andGame' then
--         return true, 1
--     else
--         return false, 6
--     end

-- end
