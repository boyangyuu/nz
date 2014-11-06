--
-- Author: Fangzhongzheng
-- Date: 2014-10-31 12:54:04
--
--------  Constants  ---------
local color_BLACK = cc.c4b(255, 255, 255, 255)
local outline_SIZE = 4

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
        -- load CCS
        content = cc.uiloader:load("xiangqian_type1.ExportJson")
        local titleLabel = cc.uiloader:seekNodeByName(content, "titleLabel")
        local describeLabel = cc.uiloader:seekNodeByName(content, "describeLabel")
        local loadLabel = cc.uiloader:seekNodeByName(content, "loadLabel")
        local buyLabel = cc.uiloader:seekNodeByName(content, "buyLabel")
        local imgPanel = cc.uiloader:seekNodeByName(content, "imgPanel")

        -- 读表替换
        titleLabel:setString((table[index])["name"])
        describeLabel:setString((table[index])["describe"])
        local img=cc.ui.UIImage.new((table[index])["imgName"]..".png")
        addChildCenter(img, imgPanel)

        -- 字体描边
        titleLabel:enableOutline(color_BLACK, outline_SIZE)
        describeLabel:enableOutline(color_BLACK, outline_SIZE)
        loadLabel:enableOutline(color_BLACK, outline_SIZE)
        buyLabel:enableOutline(color_BLACK, outline_SIZE)

        -- 获得两个按钮并设置监听
        local buyBtn = cc.uiloader:seekNodeByName(content, "buyBtn")
        local loadBtn = cc.uiloader:seekNodeByName(content, "loadBtn")
        addBtnEventListener(buyBtn, function(event)
            if event.name=='began' then
                print("buyBtn is begining!")
                return true
            elseif event.name=='ended' then
                print("buyBtn is pressed!")
            end
        end)
        addBtnEventListener(loadBtn, function(event)
            return self:onClickLoadBtn(event, string, index)
        end)

    -- Create the kind of "type = 2" listView cells
    else
        -- load ccs
        content = cc.uiloader:load("xiangqian_type2.ExportJson")
        local titleLabel = cc.uiloader:seekNodeByName(content, "titleLabel")
        local describeLabel = cc.uiloader:seekNodeByName(content, "describeLabel")
        local loadLabel = cc.uiloader:seekNodeByName(content, "loadLabel")
        local buyLabel = cc.uiloader:seekNodeByName(content, "buyLabel")
        local ownLabel = cc.uiloader:seekNodeByName(content, "ownLabel")
        local ownNum = cc.uiloader:seekNodeByName(content, "ownNum")
        local imgPanel = cc.uiloader:seekNodeByName(content, "imgPanel")


        titleLabel:setString((table[index])["name"])
        describeLabel:setString((table[index])["describe"])
        ownNum:setString("0")
        local img=cc.ui.UIImage.new((table[index])["imgName"]..".png")
        addChildCenter(img, imgPanel)

        titleLabel:enableOutline(color_BLACK, outline_SIZE)
        describeLabel:enableOutline(color_BLACK, outline_SIZE)
        loadLabel:enableOutline(color_BLACK, outline_SIZE)
        buyLabel:enableOutline(color_BLACK, outline_SIZE)
        ownLabel:enableOutline(color_BLACK, outline_SIZE)

        -- 获得两个按钮并设置监听
        local buyBtn = cc.uiloader:seekNodeByName(content, "buyBtn")
        local loadBtn = cc.uiloader:seekNodeByName(content, "loadBtn")
        addBtnEventListener(buyBtn, function(event)
            if event.name=='began' then
                print("buyBtn is begining!")
                return true
            elseif event.name=='ended' then
                print("buyBtn is pressed!")
            end
        end)
        addBtnEventListener(loadBtn, function(event)
            return self:onClickLoadBtn(event, string, index)
        end)
    end
    return content
end

function InlayListCell:onClickLoadBtn(event, string, index)
    if event.name=='began' then
        print("loadBtn is begining!")
        return true
    elseif event.name=='ended' then
        print("loadBtn is pressed!")
        self.inlayModel:refreshBtnIcon(string, index)
    end
end

return InlayListCell