import UIKit
import MobileCoreServices
import Foundation


@objc(Hello) class DemoPlugin : CDVPlugin{
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
    @objc(sayHello:) func sayHello(command: CDVInvokedUrlCommand) {
        self.commandCallback = command.callbackId
        let input = command.arguments.first as! String
        pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: input!)

         self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
}

