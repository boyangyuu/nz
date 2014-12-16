

---- View ----
-- add button event listener
function addBtnEventListener(node, callfunc)
    assert(node, "node is invalid")
    assert(callfunc, "callfunc is invalid")
    node:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)        
        if event.name=='began' then
            node:runAction(cc.ScaleTo:create(0.05, 0.9))
        elseif event.name=='ended' then
                node:runAction(cc.ScaleTo:create(0.05, 1))
        end
        local isAccepted = callfunc(event)
        return isAccepted
    end)
end

--[[
    example:self:addChild(getPopupTips("关卡尚未开启！"))
]]
function getPopupTips(text)
    assert(text, "fileName is invalid")

    -- load .ExportJson
    local popupNode = cc.uiloader:load("res/CommonPopup/commonPopup.json")
    local labelTip = cc.uiloader:seekNodeByName(popupNode, "Label_tip")
    labelTip:setString(text)
    popupNode:setTouchEnabled(true)
    popupNode:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            popupNode:removeFromParent()
            return true
        end
    end)

    -- auto remove popup windows after 2 secs.
    popupNode:runAction(transition.sequence({cc.DelayTime:create(2), cc.CallFunc:create(function()
                 popupNode:removeFromParent()
            end)}))
    -- popupNode:setZOrderOnTop(true)
    return popupNode
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
    -- if  not isTestMode() then return end
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
    local configTb = json.decode(jsonStr)
    --
    assert(configTb, "config is nil , name:"..configFileDir)
    return configTb
end

-- 通过表ID获取res下json文件内容
function getConfigByID( configFileDir, tableID )
    tableID = tonumber(tableID)
    assert(tableID ~= "" and type(tableID) == "number", 
        "invalid tableID tableName:"..configFileDir)

    local configTable = getConfig(configFileDir)
    -- dump(configTable, "configTable")
    for k,v in pairs(configTable) do
        if v["id"] == tableID then
            -- dump(v)
            return v
        end
    end
    print("not found, tableID is "..tableID)
    return nil
end

-- 通过某列属性(PropertyName)查找在表(Table)中对应的(key)的记录
-- 并返回多条记录在数组中(recordArr)
function getRecord( table, PropertyName, Key )
    assert(table ~= "" and type(table) == "table", "invalid param")
    assert(PropertyName ~= "" and type(PropertyName) == "string", "invalid param")
    -- assert(Key ~= "" and type(Key) == "string", "invalid param")
    local recordArr={}
    for k,v in pairs(table) do
        for k1,v1 in pairs(v) do
            if k1 == PropertyName and v1 == Key then
                recordArr[#recordArr + 1] = v
            end
        end
    end
    return recordArr
end

function getRecordByKey(tableName, propertyName, key)
    local table = getConfig(tableName) 
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
    dump(recordArr, "recordArr")
    return recordArr
end

function getUserData()
    return GameData.data
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

function getIsTest()
    return false
end
