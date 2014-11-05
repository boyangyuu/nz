--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 09:24:41
--
--------  Constants  ---------
local Zorder_insertLayer, Zorder_bgLayer = 10, 0

import("..includes.functionUtils")
local InlayListCell = import(".InlayListCell")
local InlayModel = import(".InlayModel")

local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
	self:initLeftBtn()
    -- print("1111111111 = ", HomeBarLayer:getImgByName("icon_jiqiang"))
end

function InlayLayer:initLeftBtn()
    -- load ccs
	cc.FileUtils:getInstance():addSearchPath("res/Inlay/")
    local inlayRootNode = cc.uiloader:load("xiangqian_main.ExportJson")
    self:addChild(inlayRootNode, Zorder_bgLayer)
    self.rootListView = cc.uiloader:seekNodeByName(inlayRootNode, "listView")

    local btnName = {
    "btn_up", "btn_down", "btn_left1", "btn_left2", "btn_left3", "btn_right1", 
    "btn_right2", "btn_right3", }
    --[[
    1.
    local inlayBtns = {"btn_left1", "btn_left2", "btn_left3", "btn_right1", 
    "btn_right2", "btn_right3", }
    btnInlay1,..6

    2. 换图问题
    bgNode a

    3.  a listView removefrompa
     add 重新load listView cc.
    ]]
    local btn = {}
    -- seek buttons and add listeners
    for i, v in ipairs(btnName) do
        btn[v] = cc.uiloader:seekNodeByName(inlayRootNode, v)

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
                    -- print("btn"..i.."is begining!")
                    return true
                elseif event.name=='ended' then
                    -- recover original color
                    for i, v in ipairs(btnName) do
                        btn[v]:setColor(cc.c3b(255, 255, 255))
                    end
                    btn[v]:setColor(cc.c3b(251, 252, 0))

                    self:refresh(i - 2)
                end
            end)
        end
    end
end

function InlayLayer:refresh(index)
    self.rootListView:removeAllChildren()

    -- listview
    self.listView = cc.ui.UIListView.new {
        viewRect = cc.rect(593, 23, 530, 500),
        direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
        :addTo(self.rootListView)

    -- read json
    local typeId = {"demage", "secure", "clip", "bullet", 
    "helper", "grenade",}
    local table = InlayModel:getConfigTable("type", typeId[index])

    -- add child
    for j = 1, #table do
        local item = self.listView:newItem()
        local content = InlayListCell:getListCell(typeId[index], index, j)
        item:addContent(content)
        item:setItemSize(514, 159)
        self.listView:addItem(item)
    end
    self.listView:reload()
end


return InlayLayer