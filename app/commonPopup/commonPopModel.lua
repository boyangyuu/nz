local commonPopModel = class("commonPopModel", cc.mvc.ModelBase)

commonPopModel.BTN_CLICK_TRUE = "BTN_CLICK_TRUE"
commonPopModel.BTN_CLICK_FALSE = "BTN_CLICK_FALSE"

function commonPopModel:ctor(properties, events, callbacks)
	commonPopModel.super.ctor(self, properties)
end

function commonPopModel:btnClickTrue()
	self:dispatchEvent({name = commonPopModel.BTN_CLICK_TRUE})
end

function commonPopModel:btnClickFalse()
	self:dispatchEvent({name = commonPopModel.BTN_CLICK_FALSE})
end

return commonPopModel