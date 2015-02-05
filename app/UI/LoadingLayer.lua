local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local LoadingLayer = class("LoadingLayer", function()
	return display.newLayer()
end)

local configs = {}
configs = {
    "黄金武器的威力巨大，会给你意外惊喜！",
    "灵活使用盾牌会救你的命哦，亲！",
    "机甲可以让你免受任何伤害，够酷吧！",
    "有些目标只有消灭杂兵后才会出来，BOSS就得摆谱嘛！",
    "火箭筒这么帅的家伙你还不拿出来秀一秀吗？那可是妹子的最爱！",
    "限时抢购的礼包我是不会错过的，亲！",
    "子弹是无限而且免费的，还有比这更爽的射击游戏吗？",
    "黄金镶嵌可以启用黄金武器哦！亲！",
    "BOSS威力强大可是干掉后会掉落武器零件哦",
    "BOSS是有弱点的哦",
    "瞄准敌人头部会有爆头伤害哦！",
    "无cd扔手雷那感觉真是额外的酸爽啊！",
}

function LoadingLayer:ctor()
	self:loadCCS()
	self:initUI()
	-- self:changeHomeLayer()
    self:setNodeEventEnabled(true)
    cc.EventProxy.new(ui, self)
        :addEventListener(ui.LOAD_SHOW_EVENT, handler(self, self.onShow))
        :addEventListener(ui.LOAD_HIDE_EVENT, handler(self, self.onHide))
    self:setVisible(false)
end

function LoadingLayer:loadCCS()
    local controlNode = cc.uiloader:load("res/Loading/loading/loading_1.json")
    self:addChild(controlNode)
end

function LoadingLayer:initUI()
	local quan = cc.uiloader:seekNodeByName(self, "quan")
    self.loadpercent = cc.uiloader:seekNodeByName(self, "loadpercent")
    self.describe = cc.uiloader:seekNodeByName(self, "describe")

    self.loadpercent:enableOutline(cc.c3b( 0, 0, 0), 2)
	local yuansrc = "res/Loading/loading_yuan/loading_yuan.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(yuansrc)

    local yuanplist = "res/Loading/loading_yuan/loading_yuan0.plist"
    local yuanpng = "res/Loading/loading_yuan/loading_yuan0.png"
    display.addSpriteFrames(yuanplist,yuanpng)

    --anim    
    self.quanarmature = ccs.Armature:create("loading_yuan")
    self.quanarmature:setAnchorPoint(0.5,0.5)
    addChildCenter(self.quanarmature, quan)
end

function LoadingLayer:setDesc()
    math.randomseed(os.time())
    local rans = math.random(1,#configs)
    self.describe:setString(configs[rans])
end

function LoadingLayer:playAnim()
    self.quanarmature:getAnimation():play("loading_z")
end

function LoadingLayer:showPercent()
    local str = 1
    for i=1,100 do
        function setString()
            self.loadpercent:setString(str.."%")
            str = str+1
        end
        scheduler.performWithDelayGlobal(setString, i*0.03)
    end
end

function LoadingLayer:onShow(event)
    self:setVisible(true)
    self:setDesc()
    self:playAnim()
    self:showPercent()
    audio.stopMusic(true)
end

function LoadingLayer:onHide(event)
    self:setVisible(false)
end

return LoadingLayer