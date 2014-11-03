--
-- Author: Fangzhongzheng
-- Date: 2014-10-24 18:17:32
--

---- View ----
-- add button event listener
function addBtnEventListener(node, callfunc)
    assert(node, "node is invalid")
    assert(callfunc, "callfunc is invalid")
    node:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        local isAccepted = callfunc(event)
        if event.name=='began' then
            node:runAction(cc.ScaleTo:create(0.05, 0.9))
        elseif event.name=='ended' then
            node:runAction(cc.ScaleTo:create(0.05, 1))
        end
        return isAccepted
    end)
end

--[[
    example:self:addChild(getPopupTips("关卡尚未开启！"))
]]
function getPopupTips(text)
    assert(text, "fileName is invalid")

    -- load .ExportJson
    local popupNode = cc.uiloader:load("res/CommonPopup/commonPopup.ExportJson")
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
    popupNode:setZOrderOnTop(true)
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
    assert(name, "name is invalid")
    assert(src, "src is invalid")
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:removeArmatureFileInfo(src)
    manager:addArmatureFileInfo(src)
    local armature = ccs.Armature:create(name) 
    return armature
end

function addChildCenter(child, parent)
    child:setPosition(parent:getBoundingBox().width/2, parent:getBoundingBox().height/2)
    child:setAnchorPoint(0.5, 0.5)
    parent:addChild(child)
end

function drawBoundingBox(parent, target, color)
    -- if isTest == false then 
    --     return 
    -- end
    local cbb = target:getCascadeBoundingBox()
    local left, bottom, width, height = cbb.origin.x, cbb.origin.y, cbb.size.width, cbb.size.height
    local points = {
        {left, bottom},
        {left + width, bottom},
        {left + width, bottom + height},
        {left, bottom + height},
        {left, bottom},
    }
    local box = display.newPolygon(points, {borderColor = color})
    parent:addChild(box, 1000)
end

function rectIntersectsRect(rectNode1, rectNode2)
    local bound1 = rectNode1:getCascadeBoundingBox()
    local bound2 = rectNode2:getCascadeBoundingBox()
    return cc.rectIntersectsRect(bound1, bound2)
end

---- Data ----
function getConfig( configFileDir )
    assert(configFileDir ~= "" and type(configFileDir) == "string", "invalid param")
    local fileUtil = cc.FileUtils:getInstance()
    local fullPath = fileUtil:fullPathForFilename(configFileDir)
    local jsonStr = fileUtil:getStringFromFile(fullPath)
    local configTb = json.decode(jsonStr)
    return configTb
end

-- 通过表ID获取res下json文件内容
function getConfigByID( configFileDir, tableID  )
    assert(tableID ~= "" and type(tableID) == "number", "invalid param")
    local configTable = getConfig(configFileDir)
    for k,v in pairs(configTable) do
        if k == tableID then
            dump(v)
            return v
        end
    end
    print("not found")
    return nil
end

-- 通过某列属性(PropertyName)查找在表(Table)中对应的(Key)的记录
-- 并返回多条记录在数组中(recordArr)
function getRecord( Table, PropertyName, Key )
    assert(Table ~= "" and type(Table) == "table", "invalid param")
    assert(PropertyName ~= "" and type(PropertyName) == "string", "invalid param")
    -- assert(Key ~= "" and type(Key) == "string", "invalid param")
    local recordArr={}
    for k,v in pairs(Table) do
        for k1,v1 in pairs(v) do
            if k1 == PropertyName and v1 == Key then
                recordArr[#recordArr + 1] = v
            end
        end
    end
    return recordArr
end
