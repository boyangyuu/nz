

local dir = "res/GiftBag/GiftBag/GiftBag_"
local configs = {
	armedMecha = {
		ccsPath = dir.."ArmedMecha.json",
		pay = ""
	},
	changshuang = {
		ccsPath = dir.."ChangShuang.json",
		pay = ""
	},
	goldGiftBag = {
		ccsPath = dir.."goldGiftBag.json",
		pay = ""
	},
	goldWeapon = {
		ccsPath = dir.."GoldWeapon.json",
		pay = ""
	},
	handGrenade = {
		ccsPath = dir.."HandGrenade.json",
		pay = ""
	},
	novicesBag = {
		ccsPath = dir.."NovicesBag.json",
		pay = ""
	},
	unlockWeapon = {
		ccsPath = dir.."UnlockWeapon.json",
		pay = ""
	},
	weaponGiftBag = {
		ccsPath = dir.."WeaponGiftBag.json",
		pay = ""
	}
}

local NovicesBagPopup = class("NovicesBagPopup", function()
	return display.newLayer()
end)

function NovicesBagPopup:ctor(properties)
	print(properties.popupName)
	self:loadCCS(properties)
	self:initButtons()
end

function NovicesBagPopup:loadCCS(properties)
	local temp = properties.popupName
	if temp and type(temp) == "string" then
		local title = configs[temp]
		print(title.ccsPath)
		local novicesBagNode = cc.uiloader:load(title.ccsPath)
	    self:addChild(novicesBagNode)
	end
end

function NovicesBagPopup:initButtons()
	local receiveBtn = cc.uiloader:seekNodeByName(self, "btn_Receive")
	receiveBtn:setTouchEnabled(true)
	addBtnEventListener(receiveBtn, function( event )
		if event.name == 'began' then 
			return true
		elseif event.name == 'ended' then
			ui:closePopup("GiftBagPopup")
			-- self:removeSelf()
			print("receiveBtn is pressed!")
		end
	end)

	local btnClose = cc.uiloader:seekNodeByName(self, "btn_Closed")
	btnClose:setTouchEnabled(true)
	addBtnEventListener(btnClose, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			ui:closePopup("GiftBagPopup")
			-- self:removeSelf()
			print("btnClose is pressed!")
		end
	end)

	for i = 0,3 do
		local bitmap = cc.uiloader:seekNodeByName(self, "BitmapLabel_2"..i)
		if bitmap then
			bitmap:setColor(cc.c3b(0, 255, 161))
		end
	end
end

return NovicesBagPopup
