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

-- add levelMap popup windows
function addPopupWindows(parent, fileName, renderLayer)
    assert(parent, "parent is invalid")
    assert(fileName, "fileName is invalid")
    assert(renderLayer, "renderLayer is invalid")

    -- load .ExportJson
    local popupNode = cc.uiloader:load(fileName)
    popupNode:setPosition(0, 0)
    popupNode:setTouchEnabled(true)
    popupNode:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            removeLevelMapPopup(popupNode)
            return true
        elseif event.name=='ended' then
        end
    end)
    parent:addChild(popupNode, renderLayer)
end

function removeLevelMapPopup(node)
    node:removeFromParent()
end

-- Cooldown the button
function disableBtn(delayTime, node)
    assert(delayTime, "delayTime is invalid")
    assert(node, "node is invalid")
    node:setTouchEnabled(false)
    transition.execute(node, cc.ScaleTo:create(0, 1), {
            delay = delayTime,
            easing = "backout",
            onComplete = function()
                node:setTouchEnabled(true)
            end,
        })
end

-- Get armature from name and src
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
    child:setPosition(parent:getContentSize().width/2, parent:getContentSize().height/2)
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
    local configTable = self:getConfig(configFileDir)
    for k,v in pairs(configTable) do
        if k == tableID then
            dump(v)
            return v
        end
    end
    print("not found")
    return nil
end