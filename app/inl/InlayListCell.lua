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
    self.inlayModel = app:getInstance(InlayModel)
end

function InlayListCell:getListCell(string, index)
    cc.FileUtils:getInstance():addSearchPath("res/Inlay/")
    local table = self.inlayModel:getConfigTable("type", string)

    -- Create the kind of "type = 1" listView cells
    local content
    if string == "demage" or string == "secure" or
     string == "clip" or string == "bullet" then
        -- loac ccs
        content = cc.uiloader:load("xiangqian_type1.ExportJson")
        local title = cc.uiloader:seekNodeByName(content, "label_title")
        local imgPanel = cc.uiloader:seekNodeByName(content, "Panel_img")
        local describe = cc.uiloader:seekNodeByName(content, "Label_describe")
        title:setString((table[index])["name"])
        describe:setString((table[index])["describe"])
        local img=cc.ui.UIImage.new((table[index])["imgName"]..".png")
        addChildCenter(img, imgPanel)

        -- 获得两个按钮并设置监听
        local btnBuy = cc.uiloader:seekNodeByName(content, "btn_buy")
        local btnLoad = cc.uiloader:seekNodeByName(content, "btn_load")
        addBtnEventListener(btnBuy, function(event)
                if event.name=='began' then
                    print("btnBuy is begining!")
                    return true
                elseif event.name=='ended' then
                    print("btnBuy is pressed!")
                end
            end)
        addBtnEventListener(btnLoad, function(event)
                if event.name=='began' then
                    print("btnLoad is begining!")
                    return true
                elseif event.name=='ended' then
                    print("btnLoad is pressed!")
                    self.inlayModel:refreshBtnIcon(string, index)
                end
            end)

    -- Create the kind of "type = 2" listView cells
    else
        -- load ccs
        content = cc.uiloader:load("xiangqian_type2.ExportJson")
        local title = cc.uiloader:seekNodeByName(content, "label_title")
        local imgPanel = cc.uiloader:seekNodeByName(content, "Panel_img")
        local describe = cc.uiloader:seekNodeByName(content, "describe")
        local ownNum = cc.uiloader:seekNodeByName(content, "label_ownNum")
        title:setString((table[index])["name"])
        describe:setString((table[index])["describe"])
        ownNum:setString("0")
        local img=cc.ui.UIImage.new((table[index])["imgName"]..".png")
        addChildCenter(img, imgPanel)

        -- 获得两个按钮并设置监听
        local btnBuy = cc.uiloader:seekNodeByName(content, "btn_buy")
        local btnLoad = cc.uiloader:seekNodeByName(content, "btn_load")
        addBtnEventListener(btnBuy, function(event)
                if event.name=='began' then
                    print("btnBuy is begining!")
                    return true
                elseif event.name=='ended' then
                    print("btnBuy is pressed!")
                end
            end)
        addBtnEventListener(btnLoad, function(event)
                if event.name=='began' then
                    print("btnLoad is begining!")
                    return true
                elseif event.name=='ended' then
                    print("btnLoad is pressed!")
                    self.inlayModel:refreshBtnIcon(string, index)
                end
            end)
    end
    return content
end

return InlayListCell