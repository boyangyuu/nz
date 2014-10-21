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
        	return true
        elseif event.name=='ended' then
            print("高亮结束")
        end
    end)
end


return ViewUtils