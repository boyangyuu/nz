

local Define = class("Define", cc.mvc.ModelBase)

--fight
Define.kGoldActivate = 20
Define.kBaoDemageOtherEnemys = 10  --自爆兵伤害值
Define.kBaoRangeW = 200
Define.kBaoRangeH = 200
function Define:ctor()
    Define.super.ctor(self) 
end

return Define

