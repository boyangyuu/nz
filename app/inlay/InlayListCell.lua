--
-- Author: Fangzhongzheng
-- Date: 2014-10-31 12:54:04
--
import("..includes.functionUtils")
local InlayModel = import(".InlayModel")
local InlayListCell = class("InlayListCell", function()
    return display.newLayer()
end)

function InlayListCell:ctor()
    -- Setting swallow, otherwise, the rootNode will cover the left buttons.
    self:setTouchEnabled(true)
    self:setTouchSwallowEnabled(false)
end

function InlayListCell:getListCell(string, index1, index2)
    cc.FileUtils:getInstance():addSearchPath("res/Inlay/")
    local table = InlayModel:getConfigTable("type", string)

    -- Create the kind of "type = 1" listView cells
    local content
    if index1 < 5 then
        -- loac ccs
        content = cc.uiloader:load("xiangqian_type1.ExportJson")
        local title = cc.uiloader:seekNodeByName(content, "label_title")
        local imgPanel = cc.uiloader:seekNodeByName(content, "Panel_img")
        local describe = cc.uiloader:seekNodeByName(content, "Label_describe")
        title:setString((table[index2])["name"])
        describe:setString((table[index2])["describe"])
        local img=cc.ui.UIImage.new((table[index2])["imgName"]..".png")
        addChildCenter(img, imgPanel)

    -- Create the kind of "type = 2" listView cells
    else
        -- load ccs
        content = cc.uiloader:load("xiangqian_type2.ExportJson")
        local title = cc.uiloader:seekNodeByName(content, "label_title")
        local imgPanel = cc.uiloader:seekNodeByName(content, "Panel_img")
        local describe = cc.uiloader:seekNodeByName(content, "describe")
        local ownNum = cc.uiloader:seekNodeByName(content, "label_ownNum")
        title:setString((table[index2])["name"])
        describe:setString((table[index2])["describe"])
        ownNum:setString("0")
        local img=cc.ui.UIImage.new((table[index2])["imgName"]..".png")
        addChildCenter(img, imgPanel)
    end
    return content
end

return InlayListCell