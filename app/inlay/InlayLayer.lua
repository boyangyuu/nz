--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 09:24:41
--
--------  Constants  ---------
local color_WHITE, color_RED = cc.c3b(255, 255, 255), cc.c3b(251, 25, 0)
local ListView_RECT = cc.rect(593, 23, 530, 500)
local ItemSize_X, ItemSize_Y = 514, 159
local Init_NUM = 1
local btn, panel = {}, {}

import("..includes.functionUtils")
local InlayListCell = import(".InlayListCell")
local InlayModel = import(".InlayModel")
-- local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")

local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
	self:initUI()
    self:addEventProtocolListener()
    self:initEnterPage()

    -- local popupCommonLayer = app:getInstance(PopupCommonLayer)
    -- print("1111111111 = ", popupCommonLayer:getImgByName("icon_jiqiang"))
end

function InlayLayer:initUI()
    -- looad CCS
    cc.FileUtils:getInstance():addSearchPath("res/Inlay/")
    local inlayRootNode = cc.uiloader:load("xiangqian_main.ExportJson")
    self:addChild(inlayRootNode)
    self.rootListView = cc.uiloader:seekNodeByName(inlayRootNode, "listView")
    local goldWeaponBtn = cc.uiloader:seekNodeByName(inlayRootNode, "btn_up")
    local oneForAllBtn = cc.uiloader:seekNodeByName(inlayRootNode, "btn_down")
    for i = 1, 6 do
        btn[i] = cc.uiloader:seekNodeByName(inlayRootNode, "btn_"..i)
        panel[i] = cc.uiloader:seekNodeByName(inlayRootNode, "Panel_"..i)
    end

    -- 添加监听
    addBtnEventListener(goldWeaponBtn, function(event)
        return self:onClickGoldWeaponBtn( event )
    end)
    addBtnEventListener(oneForAllBtn, function(event)
        return self:onClickOneForAllBtn( event )
    end)
    for i = 1, 6 do
        btn[i]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            return self:onClickBtn(event, i)
        end)
    end
end

function InlayLayer:onClickGoldWeaponBtn( event )
    if event.name =='began' then
        print("goldWeaponBtn is begining!")
        return true
    elseif event.name =='ended' then
        print("goldWeaponBtn is pressed!")
    end
end

function InlayLayer:onClickOneForAllBtn( event )
    if event.name =='began' then
        print("oneForAllBtn is begining!")
        return true
    elseif event.name =='ended' then
        print("oneForAllBtn is pressed!")
    end
end

function InlayLayer:onClickBtn(event, index)
    if event.name=='began' then
        print("1 of 6 Btns is begining!")
        return true
    elseif event.name=='ended' then
        print("1 of 6 Btns is pressed!")
        self:refreshBtncolor(index)
        self:refreshListView(index)
    end
end

function InlayLayer:addEventProtocolListener()
    self.inlayModel = app:getInstance(InlayModel)
    cc.EventProxy.new(self.inlayModel , self)
        :addEventListener("REFRESH_BTN_ICON_EVENT", handler(self, self.refreshBtnIcon))
end

function InlayLayer:initEnterPage()
    self.variable = nil
    self:refreshBtncolor(Init_NUM)
    self:refreshListView(Init_NUM)
end

function InlayLayer:refreshBtncolor(index)
    if self.variable == nil then
        btn[index]:setColor(color_RED)
        self.variable = btn[index]
    else
        self.variable:setColor(color_WHITE)
        btn[index]:setColor(color_RED)
        self.variable = btn[index]
    end
end

function InlayLayer:refreshBtnIcon(parameterTable)
    local table = self.inlayModel:getConfigTable("type", parameterTable.string)
    local img = cc.ui.UIImage.new((table[parameterTable.index])["imgName"]..".png")

    local revTypeId = {["demage"] = 1, ["secure"] = 2, ["clip"] = 3, 
    ["bullet"] = 4, ["helper"] = 5, ["grenade"] = 6,}

    local num = revTypeId[parameterTable.string]
    panel[num]:removeAllChildren()
    if num == 1 then
        img:setScale(0.5)
    end
    addChildCenter(img, panel[num])
end

function InlayLayer:refreshListView(index)
    self.rootListView:removeAllChildren()

    -- new listview
    self.listView = cc.ui.UIListView.new {
        viewRect = ListView_RECT,
        direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
        :addTo(self.rootListView)

    -- read json
    local typeId = {"demage", "secure", "clip", "bullet", 
    "helper", "grenade",}
    local table = self.inlayModel :getConfigTable("type", typeId[index])

    -- add child
    for j = 1, #table do
        local item = self.listView:newItem()
        local cell = InlayListCell.new()
        local content = cell:getListCell(typeId[index], j)
        item:addContent(content)
        item:setItemSize(ItemSize_X, ItemSize_Y)
        self.listView:addItem(item)
    end
    self.listView:reload()
end

return InlayLayer