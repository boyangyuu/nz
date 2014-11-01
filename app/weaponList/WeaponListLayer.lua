local WeaponListCell = import(".WeaponListCell")

local WeaponListLayer = class("WeaponListLayer", function()
	return display.newLayer()
end)


function WeaponListLayer:ctor()
	self:loadCCS()
	self:initUI()
end

function WeaponListLayer:loadCCS()
	-- load control bar
	cc.FileUtils:getInstance():addSearchPath("res/WeaponList")
	local controlNode = cc.uiloader:load("gunzb_1.ExportJson")
	-- controlNode:setPosition(0, 0)
    self.ui = controlNode
    self:addChild(controlNode)
end

function WeaponListLayer:initUI()
    local weaponLV = cc.uiloader:seekNodeByName(self, "ListView_49")
    self:loadWeaponList(weaponLV, getConfig("config/weapon.json"))
end

function WeaponListLayer:loadWeaponList(weaponListView, weaponTable)
	for i=1, #weaponTable do
		local weaponRecord = getConfigByID("config/weapon.json", i)
		local item = weaponListView:newItem()
		item:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
			callfunc(event)
			if event.name == 'began' then
				print("began")
			elseif event.name =='ended' then
				print("ended")
			end
		end)
		local content
		if weaponTable[i] then
			content = WeaponListCell.new(weaponRecord)
		end
		item:addContent(content)
		item:setItemSize(120, 240)
		
		weaponListView:addItem(item)
	end
	weaponListView:reload()
end

return WeaponListLayer