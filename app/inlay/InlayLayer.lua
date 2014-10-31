--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 09:24:41
--
import("..includes.functionUtils")
local InlayListView = import(".InlayListView")
local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
	self:initLeftBtn()
end

function InlayLayer:initLeftBtn()
    -- load ccs
	cc.FileUtils:getInstance():addSearchPath("res/Inlay/")
    local inlayNode = cc.uiloader:load("xiangqian_main.ExportJson")
    self:addChild(inlayNode)

    local btnName = {
    "btn_up", "btn_down", "btn_left1", "btn_left2", "btn_left3", "btn_right1", 
    "btn_right2", "btn_right3", }

    local btn = {}

    -- seek buttons and add listeners
    for i, v in ipairs(btnName) do
        btn[v] = cc.uiloader:seekNodeByName(inlayNode, v)

        if i < 3 then
            addBtnEventListener(btn[v], function(event)
                if event.name=='began' then
                    print("btn upAndDown is begining!")
                    return true
                elseif event.name=='ended' then
                    print("btn upAndDown is pressed!")
                end
            end)
        elseif i >= 3 then
            btn[v]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
                if event.name=='began' then
                    print("btn"..i.."is begining!")
                    return true
                elseif event.name=='ended' then
                    -- recover original color
                    for i, v in ipairs(btnName) do
                        btn[v]:setColor(cc.c3b(255, 255, 255))
                    end
                    btn[v]:setColor(cc.c3b(251, 252, 0))

                    -- InlayListView
                    -- if self.listView ~= nil then
                    --  self.listView:removeFromParent()
                    --  print("listView is already removeFromParent()")
                    -- end
                    -- self:refreshRightScroll(k)
                end
            end)
        end
    end
end

return InlayLayer