--
-- Author: Fangzhongzheng
-- Date: 2014-10-31 12:54:04
--
import("..includes.functionUtils")
local InlayModel = import(".InlayModel")
local InlayListCell = class("InlayListCell", function()
    return display.newLayer()
end)

function InlayListCell:ctor(index)
	self:refreshRightScroll(index)

    -- set swallow, otherwise, the left buttons arenot touching enabled
    self:setTouchEnabled(true)
    self:setTouchSwallowEnabled(false)
end

function InlayListCell:refreshRightScroll(index)
    cc.FileUtils:getInstance():addSearchPath("res/Inlay/")

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
            content = cc.uiloader:load("xiangqian_type1.ExportJson")

            item:addContent(content)
            item:setItemSize(514, 159)
            self.listView:addItem(item)
        end

    -- Create the kind of "type = 2" buttons
    elseif 2 == (table[1])["type"] then
        for i = 1, cellNum do
            local item = self.listView:newItem()

            -- load ccs
            content = cc.uiloader:load("xiangqian_type2.ExportJson")

            item:addContent(content)
            item:setItemSize(514, 159)
            self.listView:addItem(item)
        end

    -- Create the kind of "type = 3" buttons
    elseif 3 == (table[1])["type"] then
        for i = 1, cellNum do
            local item = self.listView:newItem()

            -- load ccs
            content = cc.uiloader:load("xiangqian_type3.ExportJson")
            item:addContent(content)
            item:setItemSize(514, 159)
            self.listView:addItem(item)
        end

    else
        print("The (table[1])[type] is wrong!")
    end
    self.listView:reload()
end

return InlayListCell