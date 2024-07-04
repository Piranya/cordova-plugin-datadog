import Foundation
import DatadogCore
import DatadogSessionReplay
import DatadogRUM
import DatadogCrashReporting
import DatadogLogs

@objc(Datadog) class DatadogCrash: CDVPlugin{
    
var wkSessionId:String = " "
    var isInitialized:Bool = false
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
    
    
    @objc(InitTrack:)func InitTrack(command : CDVInvokedUrlCommand){
         var result = CDVPluginResult(status: CDVCommandStatus_ERROR)
        if(!isInitialized)
        {
            let clientToken = command.argument(at: 0) as! String
            let environment = command.argument(at: 1) as! String
            let appID = command.argument(at: 2) as! String
            let trackingConsentInt = command.argument(at: 3) as! Int
            let serviceName = command.argument(at: 4) as! String
            // var sessionReplayRate = command.argument(at: 5) as! Int
            let sessionId = command.argument(at: 5) as! String
            let userName = command.argument(at: 6) as! String
            
            var trackingConsent:TrackingConsent
            switch trackingConsentInt {
            case 0:
                trackingConsent = .notGranted
                break;
            case 1:
                trackingConsent = .granted
                break;
            default:
                trackingConsent = .pending
                break;
            }
            
let session = URLSession(configuration: .default, delegate: DDURLSessionDelegate(), delegateQueue: nil)


            
Datadog.initialize(
  with: Datadog.Configuration(
    clientToken: clientToken,
    env: environment,
    service: serviceName
  ),
  trackingConsent: trackingConsent
)



RUM.enable(
    with: RUM.Configuration(
        applicationID: appID,
        uiKitViewsPredicate: DefaultUIKitRUMViewsPredicate(),
        uiKitActionsPredicate: DefaultUIKitRUMActionsPredicate()
    )
)

// if (sessionReplayRate<50){
//     sessionReplayRate  = 50
// }
SessionReplay.enable(
       with: SessionReplay.Configuration(
           replaySampleRate: 100
       )
   )
   
// Datadog.setUserInfo(name: userName) 
// Datadog.setUserInfo(id: sessionId)


Logs.enable()
   
Datadog.verbosityLevel = .debug

   let logger = Logger.create(
	with: Logger.Configuration(
		name: serviceName,
		networkInfoEnabled: true,
		remoteLogThreshold: .info,
		consoleLogFormat: .shortWith(prefix: "[iOS App] ")
	)
    )
            //let result = CDVPluginResult.init(status: CDVCommandStatus_OK)
             result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Initialized!")
            self.commandDelegate!.send(result, callbackId: command.callbackId)
        }else{
            //let result = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "Already Initialized!")
             result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Already Initialized!")
            self.commandDelegate!.send(result, callbackId: command.callbackId)
        }
    }
    
    
    @objc(setSessionId:)func getSessionId(command : CDVInvokedUrlCommand){
    //    Datadog.setUserInfo(id: command.argument(at: 0) as! String)
    }
    
    @objc(loggerMessage:)func loggerMessage(command : CDVInvokedUrlCommand){
        // logger.info("Test message")
        // logger.debug("A debug message.")
        // logger.info("Some relevant information?")
        // logger.notice("Have you noticed?")
        // logger.warn("An important warning…")
        // logger.error("An error was met!")
        // logger.critical("Something critical happened!")
    }
    
    
    @objc(setUserName:)func setUserName(command : CDVInvokedUrlCommand){
        // Datadog.setUserInfo(name: command.argument(at: 0) as! String)
    }
    
    
    // @objc(setCustomFieldSessionId:)func setCustomFieldSessionId(command : CDVInvokedUrlCommand){
        //      var result = CDVPluginResult(status: CDVCommandStatus_ERROR)
    //     wkSessionId = command.argument(at: 0) as! String
    //     if isInitialized {
    //         if self.wkSessionId.compare(" ") != .orderedSame {
    //             Global.rum.removeAttribute(forKey: "wk_UniqueIDForSession")
    //         }
    //         Global.rum.addAttribute(forKey: "wk_UniqueIDForSession", value: wkSessionId)
    //     }
    //      result = CDVPluginResult(status: CDVCommandStatus_OK)
    //     self.commandDelegate!.send(result, callbackId: command.callbackId)
    // }
    

    // @objc(getSessionId:)func getSessionId(command : CDVInvokedUrlCommand){
    //      var result = CDVPluginResult(status: CDVCommandStatus_ERROR)
    //     let uuid = UUID().uuidString
    //      result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: uuid)
    //     self.commandDelegate!.send(result, callbackId: command.callbackId)
    // }
    
    

  
    
    // @objc(setUserName:)func setUserName(command : CDVInvokedUrlCommand){
    //      var result = CDVPluginResult(status: CDVCommandStatus_ERROR)
    //      let userName = command.argument(at: 0) as! String
    //      Datadog.setUserInfo(name: userName)
    //      result = CDVPluginResult(status: CDVCommandStatus_OK)
    //     self.commandDelegate!.send(result, callbackId: command.callbackId)
    // }
    

}
