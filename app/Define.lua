

local Define = class("Define", cc.mvc.ModelBase)

--fight
Define.kGoldActivate = 20

function Define:ctor()
    Define.super.ctor(self) 
end

return Define

