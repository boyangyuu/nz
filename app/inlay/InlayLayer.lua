--
-- Author: Fangzhongzheng
-- Date: 2014-10-30 09:24:41
--
--------  Constants  ---------
local Color_WHITE, Color_RED = cc.c3b(255, 255, 255), cc.c3b(251, 25, 0)
local ListView_RECT = cc.rect(593, 23, 530, 500)
local ItemSize_X, ItemSize_Y = 514, 159
local btn = {}
local panel = {}

import("..includes.functionUtils")
local InlayListCell = import(".InlayListCell")
local InlayModel = import(".InlayModel")

-- local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local InlayLayer = class("InlayLayer", function()
    return display.newLayer()
end)

function InlayLayer:ctor()
	self:initLeftBtn()
    self:addListener()
    self:onEnter()

    -- local popupCommonLayer = app:getInstance(PopupCommonLayer)
    -- print("1111111111 = ", popupCommonLayer:getImgByName("icon_jiqiang"))
end

function InlayLayer:initLeftBtn()
    -- load ccs
	cc.FileUtils:getInstance():addSearchPath("res/Inlay/")
    local inlayRootNode = cc.uiloader:load("xiangqian_main.ExportJson")
    self:addChild(inlayRootNode)
    self.rootListView = cc.uiloader:seekNodeByName(inlayRootNode, "listView")
    
    -- seek buttons and add listeners
    local godWeaponBtn = cc.uiloader:seekNodeByName(inlayRootNode, "btn_up")
    local oneForAllBtn = cc.uiloader:seekNodeByName(inlayRootNode, "btn_down")
    addBtnEventListener(godWeaponBtn, function(event)
                if event.name=='began' then
                    print("godWeaponBtn is begining!")
                    return true
                elseif event.name=='ended' then
                    print("godWeaponBtn is pressed!")
                end
            end)
    addBtnEventListener(oneForAllBtn, function(event)
                if event.name=='began' then
                    print("oneForAllBtn is begining!")
                    return true
                elseif event.name=='ended' then
                    print("oneForAllBtn is pressed!")
                end
            end)

    -- 获得6个按钮并设置监听
    for i = 1, 6 do
        btn[i] = cc.uiloader:seekNodeByName(inlayRootNode, "btn_"..i)
        btn[i]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then
                print("1 of 6 Btns is begining!")
                return true
            elseif event.name=='ended' then
                print("1 of 6 Btns is pressed!")
                self:refreshBtnColor(i)
                self:refreshListView(i)
            end
        end)
    end

    -- 获得6个panel根节点
    for i = 1, 6 do
        panel[i] = cc.uiloader:seekNodeByName(inlayRootNode, "Panel_"..i)
    end
end

function InlayLayer:addListener()
    self.inlayModel = app:getInstance(InlayModel)
    cc.EventProxy.new(self.inlayModel , self)
        :addEventListener("REFRESH_BTN_ICON_EVENT", handler(self, self.refreshBtnIcon))
end

function InlayLayer:onEnter()
    btn[1]:setColor(Color_RED)
    self:refreshListView(1)
end

function InlayLayer:refreshBtnColor(index)
    for i = 1, 6 do
        btn[i]:setColor(Color_WHITE)
    end
    btn[index]:setColor(Color_RED)
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