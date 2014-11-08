--
-- Author: Fangzhongzheng
-- Date: 2014-11-07 21:25:10
--
import("..includes.functionUtils")
local InlayModel = import("..inlay.InlayModel")
local InlayPopup = class("InlayPopup", function()
    return display.newLayer()
end)

function InlayPopup:ctor()
end

function InlayPopup:getTipsPopup(parameterTable)
    self.popupNode = cc.uiloader:load("res/Inlay/xiangqian_popup.ExportJson")
    local firstLabel = cc.uiloader:seekNodeByName(self.popupNode, "firstLabel")
    local secondLabel = cc.uiloader:seekNodeByName(self.popupNode, "secondLabel")
    local loadLabel = cc.uiloader:seekNodeByName(self.popupNode, "loadLabel")
    local buyLabel = cc.uiloader:seekNodeByName(self.popupNode, "buyLabel")
    local noteLabel = cc.uiloader:seekNodeByName(self.popupNode, "noteLabel")
    local changeLabel = cc.uiloader:seekNodeByName(self.popupNode, "changeLabel")
    local yesBtn = cc.uiloader:seekNodeByName(self.popupNode, "yesBtn")
    local noBtn = cc.uiloader:seekNodeByName(self.popupNode, "noBtn")
    if parameterTable.btnVariable == nil then
        firstLabel:setString("装备")
        secondLabel:setString(parameterTable.table["describe2"].."零件："..
            parameterTable.table["describe1"]..parameterTable.table["valueDisplay"])
        noteLabel:setString("(注：零件一旦装备将无法卸下。)")
        changeLabel:setVisible(false)

        self:addYesBtnListener(parameterTable, yesBtn, parameterTable.string, parameterTable.index)
        self:addNoBtnListener(noBtn)
        parameterTable.btnVariable = parameterTable.table
    else
        firstLabel:setString(parameterTable.table["describe2"].."零件："..
            parameterTable.table["describe1"]..parameterTable.table["valueDisplay"])
        secondLabel:setString(parameterTable.btnVariable["describe2"].."零件："..
            parameterTable.btnVariable["describe1"]..parameterTable.btnVariable["valueDisplay"])
        noteLabel:setString("(注：更换后旧的装备将会消失。)")
        changeLabel:setVisible(true)

        self:addYesBtnListener(parameterTable, yesBtn, parameterTable.string, parameterTable.index)
        self:addNoBtnListener(noBtn)
        parameterTable.btnVariable = parameterTable.table
    end
    self.popupNode:setTouchEnabled(true)
    self.popupNode:setTouchSwallowEnabled(true)
    return self.popupNode
end

function InlayPopup:addYesBtnListener(parameterTable, btn, string, index, event)
    addBtnEventListener(btn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        	local inlayModel = app:getInstance(InlayModel)
            inlayModel:btnIconDispatch(string, index)
            inlayModel:loadedDispatch(parameterTable.btnVariable)
            self.popupNode:removeFromParent()
        end 
    end)
end

function InlayPopup:addNoBtnListener(btn)
    addBtnEventListener(btn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self.popupNode:removeFromParent()
        end
    end)
end

return InlayPopup