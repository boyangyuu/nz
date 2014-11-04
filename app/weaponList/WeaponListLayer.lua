local WeaponListCell = import(".WeaponListCell")
local WeaponListModel = import(".WeaponListModel")

local WeaponListLayer = class("WeaponListLayer", function()
	return display.newLayer()
end)


function WeaponListLayer:ctor()
	cc.FileUtils:getInstance():addSearchPath("res/WeaponList/")
	self:loadCCSJsonFile(self, "gunzb_1.ExportJson")
	-- self:loadCCS()
	self:initUI()
end

-- function WeaponListLayer:loadCCS()
-- 	-- load control bar
-- 	cc.FileUtils:getInstance():addSearchPath("res/WeaponList")
-- 	local controlNode = cc.uiloader:load("gunzb_1.ExportJson")
-- 	-- controlNode:setPosition(0, 0)
--     self.ui = controlNode
--     self:addChild(controlNode)
-- end
function WeaponListLayer:loadCCSJsonFile(scene, jsonFile)
    local node, width, height = cc.uiloader:load(jsonFile)
    width = width or display.width
    height = height or display.height
    if node then
        node:setPosition((display.width - width)/2, (display.height - height)/2)
        scene:addChild(node)
    end
end

function WeaponListLayer:initUI()
    local weaponLV = cc.uiloader:seekNodeByName(self, "ListView_49")
    weaponLV:onTouch(handler(self,self.touchListener))
    self:loadWeaponList(weaponLV, getConfig("config/weapon.json"))
    self.labelName = cc.uiloader:seekNodeByName(self, "label_name")
    self.labelDescribe = cc.uiloader:seekNodeByName(self, "label_describe")
    self.layerGun = cc.uiloader:seekNodeByName(self, "panel_gun")
    self.progBullet=cc.uiloader:seekNodeByName(self, "progress_bullet")
    self.progAccuracy=cc.uiloader:seekNodeByName(self, "progress_accuracy")
    self.progReload=cc.uiloader:seekNodeByName(self, "progress_reload")
    self:getWeaponOfCell(1)
end

function WeaponListLayer:loadWeaponList(weaponListView, weaponTable)
	for i=1, #weaponTable do
		local weaponRecord = getConfigByID("config/weapon.json", i)
		local item = weaponListView:newItem()
		-- local item
		local content
		if weaponTable[i] then
			content = WeaponListCell.new(weaponRecord)
		end
		item:addContent(content)
		item:setItemSize(120, 140)
		
		weaponListView:addItem(item)
	end
	weaponListView:reload()
end

function WeaponListLayer:touchListener(event)
    -- local listView = event.listView
    if "clicked" == event.name then
    	self:getWeaponOfCell(event.itemPos)
        event.
    end
end

function WeaponListLayer:getWeaponOfCell( index )
	-- body
	self.layerGun:removeAllChildren()
    local weaponrecord = WeaponListModel:getWeaponRecord(index)
    self.labelName:setString(weaponrecord["name"])
    self.labelDescribe:setString(weaponrecord["describe"])
	local weaponImg = cc.ui.UIImage.new("WeaponList/"..weaponrecord["imgName"]..".png")
	weaponImg:setLayoutSize(430, 180)
	addChildCenter(weaponImg, self.layerGun)
    self.progBullet:setPercent(weaponrecord["bulletNum"]/85*100)
    self.progAccuracy:setPercent(weaponrecord["accuracy"]/99*100)
    self.progReload:setPercent((1-weaponrecord["reloadTime"]/4.2)*100)

end

return WeaponListLayer