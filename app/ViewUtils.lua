--
-- Author: Fangzhongzheng
-- Date: 2014-10-20 20:36:31
--
local ViewUtils = class("ViewUtils", function()
    return display.newNode()
end)

function ViewUtils:ctor()
end


function ViewUtils:addBtnEventListener(node, callfunc)
    -- add listener
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

function ViewUtils:setGray(node)
end

function ViewUtils:removeGray(node)
end

-- Cooldown: To make button disabled for a while
function ViewUtils:disableBtn(delayTime, node)
    node:setTouchEnabled(false)
    transition.execute(node, cc.ScaleTo:create(0, 1), {
            delay = delayTime,
            easing = "backout",
            onComplete = function()
                node:setTouchEnabled(true)
            end,
        })
end

function ViewUtils:grayOrBright(node, isGray, isBright)
    if isGray then
        grayFilter = filter.newFilter("GRAY", {0.2, 0.3, 0.5, 0.1})
        node:setFilter(grayFilter)
    elseif grayFilter ~= nil then
        node:clearFilter()
    end

    if isBright then
        brightFilter = filter.newFilter("BRIGHTNESS", {0.3})
        node:setFilter(brightFilter)
    elseif brightFilter ~= nil then
        node:clearFilter()
    end       
end

function ViewUtils:getArmature(name, src)
    assert(name, "name is invalid")
    assert(src, "src is invalid")
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:removeArmatureFileInfo(src)
    manager:addArmatureFileInfo(src)
    local armature = ccs.Armature:create(name) 
    return armature
end

function ViewUtils:addChildCenter(child, parent)
    child:setPosition(parent:getContentSize().width/2, parent:getContentSize().height/2)
    parent:addChild(child)
end

return ViewUtils
