--
-- Author: Fangzhongzheng
-- Date: 2014-10-31 12:54:04
--
--------  Constants  ---------
local color_BLACK, color_ORANGE = cc.c4b(255, 255, 255, 255), cc.c4b(255, 139, 16, 255)
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
    self.inlayModel:addEventListener("EQUIPMENT_ALREADY_LOADED", 
        handler(self, self.equipmentLoaded))
end

function InlayListCell:getListCell(string, index)
    cc.FileUtils:getInstance():addSearchPath("res/Inlay/")
    local table = self.inlayModel:getConfigTable("type", string)

    -- 设置储存变量
    self.btnVariable = nil

    -- load CCS
    content = cc.uiloader:load("xiangqian_type.ExportJson")
    local titleLabel = cc.uiloader:seekNodeByName(content, "titleLabel")
    local describeLabel = cc.uiloader:seekNodeByName(content, "describeLabel")
    local describeValue = cc.uiloader:seekNodeByName(content, "describeValue")
    local goldPrice = cc.uiloader:seekNodeByName(content, "goldPrice")
    local ownNum = cc.uiloader:seekNodeByName(content, "ownNum")
    self.loadLabel = cc.uiloader:seekNodeByName(content, "loadLabel")
    local buyLabel = cc.uiloader:seekNodeByName(content, "buyLabel")
    local imgPanel = cc.uiloader:seekNodeByName(content, "imgPanel")

    -- 读表替换
    titleLabel:setString((table[index])["describe2"])
    describeLabel:setString((table[index])["describe1"])
    describeValue:setString((table[index])["valueDisplay"])
    describeValue:setColor(color_ORANGE)
    goldPrice:setString((table[index])["goldPrice"])
    ownNum:setString("100")
    local img=cc.ui.UIImage.new((table[index])["imgName"]..".png")
    addChildCenter(img, imgPanel)

    -- 字体描边
    titleLabel:enableOutline(color_BLACK, outline_SIZE)
    describeLabel:enableOutline(color_BLACK, outline_SIZE)
    describeValue:enableOutline(color_BLACK, outline_SIZE)
    goldPrice:enableOutline(color_BLACK, outline_SIZE)
    self.loadLabel:enableOutline(color_BLACK, outline_SIZE)
    ownNum:enableOutline(color_BLACK, outline_SIZE)
    buyLabel:enableOutline(color_BLACK, outline_SIZE)

    -- -- 设置字体
    -- titleLabel:setFontName(“黑体”) 
    -- describeLabel:setFontName(“黑体”)
    -- describeValue:setFontName(“黑体”)
    -- goldPrice:setFontName(“黑体”)
    -- ownNum:setFontName(“黑体”)
    -- self.loadLabel:setFontName(“黑体”)
    -- buyLabel:setFontName(“黑体”)

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
        if event.name=='began' then
            print("loadBtn is begining!")
            return true
        elseif event.name=='ended' then
            print("loadBtn is pressed!")
            self.inlayModel:popupDispatch(table[index], string, index, self.btnVariable)
        end
    end)
    return content
end

function InlayListCell:equipmentLoaded(table)
    self.loadLabel:setString("已装备")
    self.loadLabel:setTouchEnabled(false)
    self.btnVariable = table.btnVariable
end

return InlayListCell