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
    -- print("1111111111 = ", app:getImgByName("icon_jiqiang"))
end

function InlayLayer:initLeftBtn()
    -- load ccs
	cc.FileUtils:getInstance():addSearchPath("res/Inlay/")
    local inlayRootNode = cc.uiloader:load("xiangqian_main.ExportJson")
    self:addChild(inlayRootNode, Zorder_bgLayer)
    self.listView = cc.uiloader:seekNodeByName(inlayRootNode, "listView")

    local btnName = {
    "btn_up", "btn_down", "btn_left1", "btn_left2", "btn_left3", "btn_right1", 
    "btn_right2", "btn_right3", }

    local btn = {}
    -- seek buttons and add listeners
    for i, v in ipairs(btnName) do
        btn[v] = cc.uiloader:seekNodeByName(inlayRootNode, v)

        if i < 3 then
            addBtnEventListener(btn[v], function(event)
                if event.name=='began' then
                    -- print("btn upAndDown is begining!")
                    return true
                elseif event.name=='ended' then
                    -- print("btn upAndDown is pressed!")
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

                    -- 方法一：直接加
                    -- read json
                    local typeId = {"demage", "secure", "clip", "bullet", 
                    "helper", "grenade",}
                    local table = InlayModel:getConfigTable("type", typeId[i - 2])

                    for j = 1, #table do
                        local inlayListCell = InlayListCell:getListCell(typeId[i - 2], i - 2, j)
                        -- self.listView:addItem(inlayListCell)
                        -- self.listView:addChild(inlayListCell)
                        -- self:addChild(inlayListCell)
                    end

                    -- 方法二：转成item的content
                    -- self:refresh(i - 2)
                end
            end)
        end
    end
end

-- function InlayLayer:refresh(index)
--     -- read json
--     local typeId = {"demage", "secure", "clip", "bullet", 
--     "helper", "grenade",}
--     local table = InlayModel:getConfigTable("type", typeId[index])

--     -- add child
--     for j = 1, #table do
--         local item = self.listView:newItem()
--         local inlayListCell = InlayListCell:getListCell(typeId[index], index, j)
--         item:addContent(inlayListCell)
--         item:setItemSize(514, 159)
--         self.listView:addItem(item)
--     end
--     self.listView:reload()
-- end


-- function InlayLayer:refresh(index)
--     -- 方法一：判断非空后removeFromParent
--     -- if self.listView ~= nil then
--     --     self.listView:removeFromParent()
--     -- end

--     -- -- listview
--     -- self.listView = cc.ui.UIListView.new {
--     --     viewRect = cc.rect(593, 23, 530, 500),
--     --     direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
--     --     :addTo(self)

--     --方法二：加listview层，直接removeAllChildren
--     self.listView:removeAllChildren()

--     -- listview
--     self.listView = cc.ui.UIListView.new {
--         viewRect = cc.rect(593, 23, 530, 500),
--         direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
--         :addTo(self.listView)

--     -- read json
--     local typeId = {"demage", "secure", "clip", "bullet", 
--     "helper", "grenade",}
--     local table = InlayModel:getConfigTable("type", typeId[index])

--     -- add child
--     for j = 1, #table do
--         local item = self.listView:newItem()

--         -- Create the kind of "type = 1" listView content

--         -- 方法一：导入content
--         local content = InlayListCell:getListCell(typeId[index], index, j)

--         --方法二：写content
--         -- local content
--         -- if index < 5 then
--         --     -- loac ccs
--         --     content = cc.uiloader:load("xiangqian_type1.ExportJson")
--         --     local title = cc.uiloader:seekNodeByName(content, "label_title")
--         --     local imgPanel = cc.uiloader:seekNodeByName(content, "Panel_img")
--         --     local describe = cc.uiloader:seekNodeByName(content, "Label_describe")
--         --     title:setString((table[j])["name"])
--         --     describe:setString((table[j])["describe"])
--         --     local img=cc.ui.UIImage.new((table[j])["imgName"]..".png")
--         --     addChildCenter(img, imgPanel)

--         -- -- Create the kind of "type = 2" listView content
--         -- else
--         --     -- load ccs
--         --     content = cc.uiloader:load("xiangqian_type2.ExportJson")
--         --     local title = cc.uiloader:seekNodeByName(content, "label_title")
--         --     local imgPanel = cc.uiloader:seekNodeByName(content, "Panel_img")
--         --     local describe = cc.uiloader:seekNodeByName(content, "describe")
--         --     local ownNum = cc.uiloader:seekNodeByName(content, "label_ownNum")
--         --     title:setString((table[j])["name"])
--         --     describe:setString((table[j])["describe"])
--         --     ownNum:setString("0")
--         --     local img=cc.ui.UIImage.new((table[j])["imgName"]..".png")
--         --     addChildCenter(img, imgPanel)
--         -- end
--         item:addContent(content)
--         item:setItemSize(514, 159)
--         self.listView:addItem(item)
--     end
--     self.listView:reload()
-- end

return InlayLayer