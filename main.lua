-- require("debugger")("192.168.1.86",10240,"luasoar",nil,"unix","/Users/donniesuen/Documents/MyRepository/client/demoFight")
local myApp = require("app.MyApp").new()
myApp:run()
-- local debug = myApp:initDebug()
-- -- debug = require("app.debug.DebugModel").new()

function __G__TRACKBACK__(errorMessage)
	local debugInfo = {}
	debugInfo["errormessage"] = errorMessage
	debugInfo["tracebackinfo"] = debug.traceback("",2)

    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
    myApp:showError(debugInfo)
end


