-- LanguageManager.lua
--[[
版权：haoge@technology 2015
作用: 多语言控制
作者: mingjian.wang
时间: 2015.8.26
备注:
]]

--[[
新添加语言时应在 res/language/ 下添加语言文件，格式如下：

-- zh.lua 以语言缩写命名
local lan = {
    hello = "你好",
}
return lan

并在 languageNameTable 中添加相应的语言名，key 为语言缩写。

在代码中加入语言：
-- local hello = "你好"
local hello = getStringForKey("hello")
--]]

local LAN_PATH = "app.language."
local languageNameTable = {
    cn = "中文",
    en = "English",
}
local defaultLan = "cn"

LanguageManager = {}
LanguageManager._currentLanguage = nil
LanguageManager._languageTable = nil

function LanguageManager.init()
    if lan == "" then
        lan = defaultLan
    end
    LanguageManager.loadLanguage(lan)
    LanguageManager._currentLanguage = lan
end

function LanguageManager.setLanguage(lan)
    if lan and languageNameTable[lan] then
        Log.d("set language[%s]", tostring(languageNameTable[lan]))
        LanguageManager.loadLanguage(lan)
        LanguageManager._currentLanguage = lan
    end
end

function LanguageManager.getLanguageName()
    local strLanguage = ""
    if device.language == "cn" then
        strLanguage = "zh"
    else
        strLanguage = "en"
    end
    return strLanguage
end

function LanguageManager.loadLanguage(lan)
    if not lan then return end
    LanguageManager._languageTable = require(LAN_PATH .. lan)
    if LanguageManager._languageTable == nil then
        Log.d("load language[%s] failed", tostring(lan))
    end
end

function LanguageManager.getStringForKey(key)
    -- body
    if key and LanguageManager._languageTable[key] then
        return LanguageManager._languageTable[key]
    end
    return nil
end
