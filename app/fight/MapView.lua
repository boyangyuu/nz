
--[[--

“战斗地图”的视图
desc： 
	1.生成enemy
	2.加载地图 	
	3.enemy的活动
	4.攻击检测
]]
local kScaleBg = 2
local Hero = import(".Hero")

local MapView = class("MapView", function()
    return display.newNode()
end)

function MapView:ctor()
	--model
	self.hero = app:getInstance(Hero)

	--map
	local mapId = ""   -- todo 外界
	self.bgMap = display.newSprite("Fight/maps/map_demo"..mapId..".png") 
	self:addChild(self.bgMap)
end

function MapView:createEnemys()
	
end

function MapView:getSize( )
	local size = cc.size(self.bgMap:getBoundingBox().width * kScaleBg ,
		self.bgMap:getBoundingBox().height * kScaleBg)
	return size
end

return MapView