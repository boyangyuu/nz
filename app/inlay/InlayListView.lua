--
-- Author: Fangzhongzheng
-- Date: 2014-10-31 12:54:04
--
import("..includes.functionUtils")
local InlayModel = import(".InlayModel")
local InlayListView = class("InlayListView", function()
    return display.newLayer()
end)

function InlayListView:ctor(index)
	self:refreshRightScroll(index)
end

function InlayListView:refreshRightScroll(index)
	-- listview
    self.listView = cc.ui.UIListView.new {
        viewRect = cc.rect(593, 23, 530, 500),
        direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
        :addTo(self)

    local table = InlayModel:getConfigTable("typeId", index)
    local cellNum = #table
    local content

    -- Create the kind of "type = 1" button
    if 1 == (table[1])["type"] then
        for i = 1, cellNum do
            local item = self.listView:newItem()

            -- loac ccs
            content = 
            

            item:addContent(content)
            item:setItemSize(514, 159)
            self.listView:addItem(item)
        end

    -- Create the kind of "type = 2" buttons
    elseif 2 == (table[1])["type"] then
        for i = 1, cellNum do
            local item = self.listView:newItem()

            -- load ccs
            content = 

            item:addContent(content)
            item:setItemSize(514, 159)
            self.listView:addItem(item)
        end

    -- Create the kind of "type = 3" buttons
    else
        for i = 1, cellNum do
            local item = self.listView:newItem()

            -- load ccs
            content = cc.uiloader:load("inlay/xiangqian_type3.ExportJson")
            item:addContent(content)
            item:setItemSize(514, 159)
            self.listView:addItem(item)
        end
    end
    self.listView:reload()
end

return InlayListView