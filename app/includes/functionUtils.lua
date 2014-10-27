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
        callfunc(event)
        if event.name=='began' then
        	print("高亮!")
            -- self:grayOrBright(self.nodeSprite, true, false)
        	return true
        elseif event.name=='ended' then
            -- self:grayOrBright(self.nodeSprite, false, false)
            print("高亮结束")
        end
    end)
end

-- add levelMap popup windows  -- self:addChild(getPopupLayer("关卡尚未开启！"), 100)
function getPopupLayer(text)
    assert(text, "fileName is invalid")

    -- load .ExportJson
    local popupNode = cc.uiloader:load("res/LevelMap_popup/levelMap_popup.ExportJson")
    local labelTip = cc.uiloader:seekNodeByName(popupNode, "Label_tip")
    labelTip:setString(text)
    popupNode:setTouchEnabled(true)
    popupNode:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            popupNode:removeFromParent()
            return true
        elseif event.name=='ended' then
        end
    end)

    -- auto remove popup windows after 2 secs.
    popupNode:runAction(transition.sequence({cc.DelayTime:create(2), cc.CallFunc:create(function()
                 popupNode:removeFromParent()
            end)}))
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