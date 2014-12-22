
--[[--

“枪”的视图

]]
import("..includes.functionUtils")
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")

--events

local DefenceView = class("DefenceView", function()
    return display.newNode()
end)

function DefenceView:ctor()
	--instance
	-- dump(properties, "DefenceView properties")
	self.hero = md:getInstance(Hero)

	--event
	-- cc.EventProxy.new(self.hero, self)
 --        :addEventListener(Hero.GUN_CHANGE_EVENT, handler(self, self.playChange))
	-- cc.EventProxy.new(self.inlay, self)
 --        :addEventListener(FightInlay.INLAY_GOLD_BEGIN_EVENT, handler(self, self.onActiveGold))
 --        :addEventListener(FightInlay.INLAY_GOLD_END_EVENT,	 handler(self, self.onActiveGoldEnd))
end

return DefenceView