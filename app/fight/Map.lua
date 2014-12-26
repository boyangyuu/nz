 --[[--

“枪”的实体

]]

--includes

local Map = class("Map", cc.mvc.ModelBase)

--events
Map.EFFECT_LEI_BOMB_EVENT = "EFFECT_LEI_BOMB_EVENT"

function Map:ctor()
    Map.super.ctor(self)
end

return Map