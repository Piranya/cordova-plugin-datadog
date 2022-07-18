
    @objc(setUserName:)func setUserName(command : CDVInvokedUrlCommand){
         var result = CDVPluginResult(status: CDVCommandStatus_ERROR)
         let userName = command.argument(at: 0) as! String
         Datadog.setUserInfo(name: userName)
         result = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate!.send(result, callbackId: command.callbackId)
    }
    
