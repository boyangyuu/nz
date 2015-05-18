local FightAdviseModel = class("FightAdviseModel", cc.mvc.ModelBase)


function FightAdviseModel:ctor(properties)
    FightAdviseModel.super.ctor(self, properties)

    --instance
    self.weaponModel = md:getInstance("WeaponListModel")

end


function FightAdviseModel:showAdvise(data)
    local isJijia = data.type == "goldJijia" 
    local isWeaponExist = self.weaponModel:isWeaponExist(data.gunId)
    if isWeaponExist and not isJijia then return end
    ui:showPopup("FightAdvisePopup", 
        data, 
        {animName = "scale"})    
end

return FightAdviseModel