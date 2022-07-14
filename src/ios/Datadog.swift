//
//  Datadog.swift
//  test
//
//  Created by Luis Bouça on 04/10/2021.
//

import Foundation
import Datadog
import DatadogCrashReporting

@objc(Datadog) class DatadogCrash: CDVPlugin{
    
    var wkSessionId:String = " "
    var isInitialized:Bool = false
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
    
    @objc(Init:)func Init(command : CDVInvokedUrlCommand){
         var result = CDVPluginResult(status: CDVCommandStatus_ERROR)
        if(!isInitialized){
            let clientToken = command.argument(at: 0) as! String
            let enviourment = command.argument(at: 1) as! String
            let appID = command.argument(at: 2) as! String
            let trackingConsentInt = command.argument(at: 3) as! Int
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
            Datadog.initialize(
                appContext: .init(),
                trackingConsent: trackingConsent,
                configuration: Datadog.Configuration
                .builderUsing(
                    rumApplicationID: appID,
                    clientToken: clientToken,
                    environment: enviourment
                )        
                .set(serviceName: "SI NEW")
                .trackUIKitRUMViews()
                .enableCrashReporting(using: DDCrashReportingPlugin())
                .trackBackgroundEvents()
                .build()
            )
            Datadog.verbosityLevel = .debug
            Global.rum = RUMMonitor.initialize()
            if self.wkSessionId.compare(" ") != .orderedSame {
                Global.rum.addAttribute(forKey: "wk_UniqueIDForSession", value: wkSessionId)
            }
            
            let logger = Logger.builder
            .sendNetworkInfo(true)
            .printLogsToConsole(true, usingFormat: .shortWith(prefix: "[iOS App] "))
            .build()
            
            logger.debug("A debug message.")
logger.info("Some relevant information?")
logger.notice("Have you noticed?")
logger.warn("An important warning…")
logger.error("An error was met!")
logger.critical("Something critical happened!")
            
            //let result = CDVPluginResult.init(status: CDVCommandStatus_OK)
             result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Initialized!")
            self.commandDelegate!.send(result, callbackId: command.callbackId)
        }else{
            //let result = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "Already Initialized!")
             result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Already Initialized!")
            self.commandDelegate!.send(result, callbackId: command.callbackId)
        }
    }
    @objc(setCustomFieldSessionId:)func setCustomFieldSessionId(command : CDVInvokedUrlCommand){
         var result = CDVPluginResult(status: CDVCommandStatus_ERROR)
        wkSessionId = command.argument(at: 0) as! String
        if isInitialized {
            if self.wkSessionId.compare(" ") != .orderedSame {
                Global.rum.removeAttribute(forKey: "wk_UniqueIDForSession")
            }
            Global.rum.addAttribute(forKey: "wk_UniqueIDForSession", value: wkSessionId)
        }
         result = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate!.send(result, callbackId: command.callbackId)
    }
    @objc(getSessionId:)func getSessionId(command : CDVInvokedUrlCommand){
         var result = CDVPluginResult(status: CDVCommandStatus_ERROR)
        let uuid = UUID().uuidString
         result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: uuid)
        self.commandDelegate!.send(result, callbackId: command.callbackId)
    }

    @objc(setTrackingConsent:)func setTrackingConsent(command : CDVInvokedUrlCommand){
         var result = CDVPluginResult(status: CDVCommandStatus_ERROR)
        let trackingConsentInt = command.argument(at: 0) as! Int
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
        Datadog.set(trackingConsent: trackingConsent)
         result = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate!.send(result, callbackId: command.callbackId)
    }
}
