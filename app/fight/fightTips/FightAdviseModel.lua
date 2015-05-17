local FightAdviseModel = class("FightAdviseModel", cc.mvc.ModelBase)


function FightAdviseModel:ctor(properties)
    FightAdviseModel.super.ctor(self, properties)

    --instance
    self.weaponModel = md:getInstance("WeaponListModel")

end


function FightAdviseModel:showAdvise(data)
    if data.type == "goldJijia" then return end
    local isWeaponExist = self.weaponModel:isWeaponExist(data.gunId)
    if isWeaponExist then return end
    ui:showPopup("FightAdvisePopup", 
        data, 
        {animName = "scale"})    
end

return FightAdviseModel