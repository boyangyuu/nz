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

function InlayPopup:getTipsPopup(table)
    self.popupbtn = cc.uiloader:load("res/Inlay/xiangqian_popup.ExportJson")
    local firstLabel = cc.uiloader:seekbtnByName(self.popupbtn, "firstLabel")
    local secondLabel = cc.uiloader:seekbtnByName(self.popupbtn, "secondLabel")
    local loadLabel = cc.uiloader:seekbtnByName(self.popupbtn, "loadLabel")
    local buyLabel = cc.uiloader:seekbtnByName(self.popupbtn, "buyLabel")
    local noteLabel = cc.uiloader:seekbtnByName(self.popupbtn, "noteLabel")
    local changeLabel = cc.uiloader:seekbtnByName(self.popupbtn, "changeLabel")
    local confirmBtn = cc.uiloader:seekbtnByName(self.popupbtn, "confirmBtn")
    local cancelBtn = cc.uiloader:seekbtnByName(self.popupbtn, "cancelBtn")
    if table.btnVariable == nil then
        firstLabel:setString("装备")
        secondLabel:setString(table.table["describe2"].."零件："..
            table.table["describe1"]..table.table["valueDisplay"])
        noteLabel:setString("(注：零件一旦装备将无法卸下。)")
        changeLabel:setVisible(false)

        self:initConfirmBtn(table, yesBtn)
        self:initCancelBtn(noBtn)
        table.btnVariable = table.table
    else
        firstLabel:setString(table.table["describe2"].."零件："..
            table.table["describe1"]..table.table["valueDisplay"])
        secondLabel:setString(table.btnVariable["describe2"].."零件："..
            table.btnVariable["describe1"]..table.btnVariable["valueDisplay"])
        noteLabel:setString("(注：更换后旧的装备将会消失。)")
        changeLabel:setVisible(true)

        self:initConfirmBtn(table, yesBtn)
        self:initCancelBtn(noBtn)
        table.btnVariable = table.table
    end
    self.popupbtn:setTouchEnabled(true)
    self.popupbtn:setTouchSwallowEnabled(true)
    return self.popupbtn
end

function InlayPopup:initConfirmBtn(table, btn)
    addBtnEventListener(btn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        	local inlayModel = app:getInstance(InlayModel)
            inlayModel:btnIconDispatch(string, index)
            inlayModel:loadedDispatch(table.btnVariable)

            --model setdata
            --dispach listView refresh
            self.popupbtn:removeFromParent()
        end 
    end)
end

function InlayPopup:initCancelBtn(btn)
    addBtnEventListener(btn, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self.popupbtn:removeFromParent()
        end
    end)
end

return InlayPopup