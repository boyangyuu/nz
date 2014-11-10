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
    self:setTouchEnabled(true)
    self:setTouchSwallowEnabled(false)
    self.inlayModel = app:getInstance(InlayModel)
    cc.EventProxy.new(self.inlayModel, self)
        :addEventListener(InlayModel.EQUIPMENT_ALREADY_LOADED, handler(self, self.equipmentLoaded))
end

function InlayListCell:getListCell(type, index)
    cc.FileUtils:getInstance():addSearchPath("res/InlayShop/")

    -- load CCS
    content             = cc.uiloader:load("xiangqian_type.ExportJson")
    self.titleLabel     = cc.uiloader:seekNodeByName(content, "titleLabel")
    self.describeLabel  = cc.uiloader:seekNodeByName(content, "describeLabel")
    self.describeValue  = cc.uiloader:seekNodeByName(content, "describeValue")
    self.goldPrice      = cc.uiloader:seekNodeByName(content, "goldPrice")
    self.ownNum         = cc.uiloader:seekNodeByName(content, "ownNum")
    self.loadLabel      = cc.uiloader:seekNodeByName(content, "loadLabel")
    self.buyLabel       = cc.uiloader:seekNodeByName(content, "buyLabel")
    self.imgPanel       = cc.uiloader:seekNodeByName(content, "imgPanel")
    self.buyBtn         = cc.uiloader:seekNodeByName(content, "buyBtn")
    self.loadBtn        = cc.uiloader:seekNodeByName(content, "loadBtn")

    self:refreshListCell(type, index)
    return content
end

function InlayListCell:refreshListCell(type, index)
    -- 读表替换
    local table = self.inlayModel:getConfigTable("type", type)
    self.titleLabel   :setString((table[index])["describe2"])
    self.describeLabel:setString((table[index])["describe1"])
    self.describeValue:setString((table[index])["valueDisplay"])
    self.describeValue:setColor(cc.c4b(255, 139, 16, 255))
    self.goldPrice    :setString((table[index])["goldPrice"])
    self.img=cc.ui.UIImage.new((table[index])["imgName"]..".png")
    addChildCenter(self.img, self.imgPanel)

    -- 字体描边
    -- self.titleLabel:enableOutline(cc.c3b(255, 0, 0), 4)
    -- self.describeLabel:enableOutline(color_BLACK, 4)
    -- self.describeValue:enableOutline(color_BLACK, 4)
    -- self.goldPrice:enableOutline(color_BLACK, 4)
    -- self.loadLabel:enableOutline(color_BLACK, 4)
    -- self.ownNum:enableOutline(color_BLACK, 4)
    -- self.buyLabel:enableOutline(color_BLACK, 4)

    -- 注册监听
    addBtnEventListener(self.buyBtn, function(event)
        if event.name=='began' then
            print("buyBtn is begining!")
            return true
        elseif event.name=='ended' then
            print("buyBtn is pressed!")
        end
    end)
    addBtnEventListener(self.loadBtn, function(event)
        if event.name=='began' then
            print("loadBtn is begining!")
            return true
        elseif event.name=='ended' then
            print("loadBtn is pressed!")
            self.inlayModel:popupDispatch(type, self.index)
        end
    end)
end

return InlayListCell