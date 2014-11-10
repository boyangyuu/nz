
--[[--

“英雄”的视图

]]

--import
import("..includes.functionUtils")
local Hero = import(".Hero")

local HeroView = class("HeroView", function()
    return display.newNode()
end)

function HeroView:ctor(properties)
	--instance
	self.hero = app:getInstance(Hero)



end


return HeroView
