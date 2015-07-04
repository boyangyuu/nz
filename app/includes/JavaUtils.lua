local JavaUtils = class("JavaUtils",cc.mvc.ModelBase)

                     
function JavaUtils.getIapType()   -- "confirm", "noIap", "noConfirm"
    if device.platform ~= 'android' then return "confirm" end
    local className = "com/hgtt/com/IAPControl"
    local methodName = "getIapType"
    local args = {}
    local sig = "()Ljava/lang/String;"
    local luajResult, iapType = luaj.callStaticMethod(className, methodName, args, sig)
    print("iapType:", iapType)
    if luajResult then
        return iapType
    end
    return "confirm"
end

function JavaUtils.getIsGiftValid()
    if device.platform ~= 'android' then return true end
    local result,status = luaj.callStaticMethod("com/hgtt/com/IAPControl", 
        "getIapGiftStatus", {}, "()Ljava/lang/String;")
    local isValid = status == "open"
    print("function JavaUtils.getIsGiftValid()", isValid)
    -- return false
    return isValid
end

function JavaUtils.getIapName()
    if device.platform ~= 'android' then return 'invalid' end
    local result,iapName = luaj.callStaticMethod("com/hgtt/com/IAPControl", 
        "getIapStatus", {}, "()Ljava/lang/String;")
    print("iapName:",iapName)
    return iapName

end

--sim为移动jd
function JavaUtils.isSIMJD()
    if device.platform ~= 'android' then return true end
    return JavaUtils.getIapName() == "jd"
end

--sim为dx
function JavaUtils.isSIMDX()
    -- return true
    if JavaUtils.getIapName() == "dx" then
        return true
    else
        return false
    end
end

--[[
    @sdkName : al,wx,jd,mm,dx,lt
    @return : bool
]]
function JavaUtils.getIsIapSDKValid(sdkName)
    print("function getIsIapSDKValid(sdkName)", sdkName)
    if device.platform == 'android' then
        local result,valid = luaj.callStaticMethod(
            "com/hgtt/com/IAPControl", 
            "getIsIapSDKValid", 
            {sdkName}, 
            "(Ljava/lang/String;)Z")
        return valid
    end
    return true
end

function JavaUtils.getIsShenhe()
    local d = os.date("*t")
    if d.year <= 2015 and d.month <= 7 and d.day <= 8 then 
        return true
    else
        return false
    end
end

return JavaUtils