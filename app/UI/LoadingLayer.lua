local LoadingLayer = class("LoadingLayer", function()
	return display.newLayer()
end)

local configs = {}
configs = {
    LanguageManager.getStringForKey("string_hint188"),
    LanguageManager.getStringForKey("string_hint189"),
    LanguageManager.getStringForKey("string_hint190"),
    LanguageManager.getStringForKey("string_hint191"),
    LanguageManager.getStringForKey("string_hint192"),
    LanguageManager.getStringForKey("string_hint193"),
    LanguageManager.getStringForKey("string_hint194"),
    LanguageManager.getStringForKey("string_hint195"),
}

function LoadingLayer:ctor()
    self:setNodeEventEnabled(true)
    cc.EventProxy.new(ui, self)
        :addEventListener(ui.LOAD_SHOW_EVENT, handler(self, self.onShow))
        :addEventListener(ui.LOAD_HIDE_EVENT, handler(self, self.onHide))
    self:setVisible(false)
end

function LoadingLayer:loadGiftCCS()
    math.randomseed(os.time())
    local rans = math.random(2,4)
    local controlNode = cc.uiloader:load("res/Loading/loading/loading_"..rans..".json")
    self:addChild(controlNode)
end

function LoadingLayer:loadNomalCCS()
    local controlNode = cc.uiloader:load("res/Loading/loading/loading_1.json")
    self:addChild(controlNode)

end

function LoadingLayer:initUI()
	local quan = cc.uiloader:seekNodeByName(self, "quan")
    self.loadpercent = cc.uiloader:seekNodeByName(self, "loadpercent")
    self.describe = cc.uiloader:seekNodeByName(self, "describe")

    self.loadpercent:enableOutline(cc.c3b( 0, 0, 0), 2)

    cc.FileUtils:getInstance():addSearchPath("res/Loading/loading_yuan")
    self.img1 = cc.ui.UIImage.new("loadingz_di02.png")
    self.img2 = cc.ui.UIImage.new("loadingz_wai.png")
    self.img3 = cc.ui.UIImage.new("loadingz_zhong.png")
    addChildCenter(self.img1,quan)
    addChildCenter(self.img2,quan)
    addChildCenter(self.img3,quan)
end

function LoadingLayer:setDesc()
    math.randomseed(os.time())
    local rans = math.random(1,#configs)
    self.describe:setString(configs[rans])
end

function LoadingLayer:playAnim()
    local action1 = cc.RotateTo:create(0.5, -180)
    local action2 = cc.RotateTo:create(0.5, -360)
    local action3 = cc.RotateTo:create(0.5,  180)
    local action4 = cc.RotateTo:create(0.5,  360)

    local seq1 = cc.Sequence:create(action1, action2)
    local seq2 = cc.Sequence:create(action3, action4)

    self.img2:runAction(cc.RepeatForever:create(seq1))
    self.img3:runAction(cc.RepeatForever:create(seq2))
end

function LoadingLayer:showPercent()
    local str = 1
    for i=1,100 do
        function setString()
            self.loadpercent:setString(str.."%")
            str = str+1
            if str > 100 then
                transition.stopTarget(self.loadpercent)
            end

        end
        self.loadpercent:schedule(setString, i*0.05)
    end
end

function LoadingLayer:loadCCS()
    local guide = md:getInstance("Guide")
    local isNotDone = guide:isDone("xiangqian") == false

    if isNotDone then
        self:loadNomalCCS()
    elseif self.loadType == "home"then
        self:loadGiftCCS()
    elseif self.loadType == "fight" or self.loadType == "home_first" then
        self:loadNomalCCS()
    end
end

function LoadingLayer:onShow(event)
    self.loadType = event.type
    self:loadCCS()
    self:initUI()
    self:setVisible(true)
    self:setDesc()
    self:playAnim()
    self:showPercent()
    audio.stopMusic(true)
end

function LoadingLayer:onHide(event)
    self:setVisible(false)
    self:removeAllChildren()
end

return LoadingLayer