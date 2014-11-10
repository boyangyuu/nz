--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 09:24:41
--
--------  Constants  ---------
local btn, btnRed, panel, label, typeId, item, itemVariable
    = {}, {}, {}, {}, {}, {}, {}

import("..includes.functionUtils")
local InlayListCell = import(".InlayListCell")
local InlayModel    = import(".InlayModel")
local InlayPopup    = import(".InlayPopup")
local InlayLayer    = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
	self:initUI()
    self:initEventProtocol()
    self:initEnterPage()
end

function InlayLayer:initUI()
    -- looad CCS
    cc.FileUtils:getInstance():addSearchPath("res/InlayShop/")
    local inlayRootNode   = cc.uiloader:load("xiangqian_main.ExportJson")
    self.listView         = cc.uiloader:seekNodeByName(inlayRootNode, "listView")
    local goldWeaponBtn   = cc.uiloader:seekNodeByName(inlayRootNode, "goldWeaponBtn")
    local oneForAllBtn    = cc.uiloader:seekNodeByName(inlayRootNode, "oneForAllBtn")
    local goldWeaponLabel = cc.uiloader:seekNodeByName(inlayRootNode, "goldWeaponLabel")
    local oneForAllLabel  = cc.uiloader:seekNodeByName(inlayRootNode, "oneForAllLabel")
    self:addChild(inlayRootNode)

    -- 6个按钮的类型
    typeId = {"bullet", "clip", "speed", "aim", "blood", "helper",}

    for i = 1, 6 do
        btn[i]    = cc.uiloader:seekNodeByName(inlayRootNode, "btn"..i)
        btnRed[i] = cc.uiloader:seekNodeByName(inlayRootNode, "btnRed"..i)
        panel[i]  = cc.uiloader:seekNodeByName(inlayRootNode, "panel"..i)
        label[i]  = cc.uiloader:seekNodeByName(inlayRootNode, "label"..i)
        btnRed[i]:setVisible(false)
        btn[i]   :addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            return self:onClickBtn(event, i, typeId[i])
        end)
    end
    
    -- 添加监听
    addBtnEventListener(goldWeaponBtn, function(event)
        return self:onClickGoldWeaponBtn(event)
    end)
    addBtnEventListener(oneForAllBtn, function(event)
        return self:onClickOneForAllBtn(event)
    end)
end

function InlayLayer:onClickGoldWeaponBtn(event)
    if event.name =='began' then
        print("goldWeaponBtn is begining!")
        return true
    elseif event.name =='ended' then
        print("goldWeaponBtn is pressed!")
    end
end

function InlayLayer:onClickOneForAllBtn(event)
    if event.name =='began' then
        print("oneForAllBtn is begining!")
        return true
    elseif event.name =='ended' then
        print("oneForAllBtn is pressed!")
    end
end

function InlayLayer:onClickBtn(event, index, type)
    if event.name=='began' then
        return true
    elseif event.name=='ended' then
        self:refreshBtncolor(index)
        self:refreshListView(type)
    end
end

function InlayLayer:initEventProtocol()
    self.inlayModel = app:getInstance(InlayModel)
    cc.EventProxy.new(self.inlayModel, self)
        :addEventListener(InlayModel.REFRESH_BTN_ICON_EVENT, handler(self, self.refreshBtnIcon))
        :addEventListener(InlayModel.INLAY_POPUP_TIPS_EVENT, handler(self, self.showInlayPopup))
end

function InlayLayer:initEnterPage()
    self.variable1 = nil
    self.variable2 = nil
    self:refreshBtncolor(1)
    self:refreshListView("bullet")
end

function InlayLayer:refreshBtncolor(index)
    if self.variable1 == nil then
        btnRed[index]:setVisible(true)
        btn[index]:setVisible(false)
        self.variable1 = btnRed[index]
        self.variable2 = btn[index]
    else
        self.variable1:setVisible(false)
        self.variable2:setVisible(true)
        btnRed[index]:setVisible(true)
        btn[index]:setVisible(false)
        self.variable1 = btnRed[index]
        self.variable2 = btn[index]
    end
end

function InlayLayer:refreshBtnIcon(table_)
    local table = self.inlayModel:getConfigTable("type", table_.string)
    local img = cc.ui.UIImage.new((table[table_.index])["imgName"]..".png")

    local revTypeId = {["bullet"] = 1, ["clip"] = 2, ["speed"] = 3, 
    ["aim"] = 4, ["blood"] = 5, ["helper"] = 6,}

    local num = revTypeId[table_.string]
    panel[num]:removeAllChildren()
    addChildCenter(img, panel[num])
end

function InlayLayer:refreshListView(type)
    local table = self.inlayModel:getConfigTable("type", type)
    local listCell = InlayListCell.new()

    -- 初始化item
    if itemVariable[1] == nil then
        -- add child
        for i = 1, #table do
            item[i] = self.listView:newItem()
            local content = listCell:getListCell(type, i)
            item[i]:addContent(content)
            item[i]:setItemSize(514, 159)
            self.listView:addItem(item[i])
            itemVariable[i] = item[i]
        end
        self.listView:reload()
        return true
    else
    -- 删除item
        for i = 1, #table do
            -- 删除item出错，当注释掉时，依然会加上4个item；当取消注释时，无法添加。
            -- self.listView:removeItem(itemVariable[i])
        end

    -- 添加item
        for i = 1, #table do
            item[i] = self.listView:newItem()
            local content = listCell:getListCell(type, i)
            item[i]:addContent(content)
            item[i]:setItemSize(514, 159)
            self.listView:addItem(item[i])
            itemVariable[i] = item[i]
        end
        self.listView:reload()
    end
end

function InlayLayer:showInlayPopup(table)
    local inlayPopup = InlayPopup.new()
    self:addChild(inlayPopup:getTipsPopup(table), 100)
end

return InlayLayer