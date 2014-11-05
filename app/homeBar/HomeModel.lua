--
-- Author: Fangzhongzheng
-- Date: 2014-11-05 18:14:08
--
import("..includes.functionUtils")

local HomeModel = class("HomeModel", cc.mvc.ModelBase)

function HomeModel:ctor(properties)
	HomeModel.super.ctor(self, properties)
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function HomeModel:panelAction()
	self:dispatchEvent({name = "HOMEBAR_ACTION_UP_EVENT"})
end

return HomeModel