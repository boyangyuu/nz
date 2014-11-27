-- require("debugger")("192.168.1.86",10240,"luasoar",nil,"unix","/Users/donniesuen/Documents/MyRepository/client/demoFight")
function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end

require("app.MyApp").new():run()
