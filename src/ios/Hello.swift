import UIKit
import MobileCoreServices
import Foundation


@objc(Hello) class DemoPlugin : CDVPlugin{
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
    @objc(sayHello:) func sayHello(_ command: CDVInvokedUrlCommand) {
      pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: command.arguments[0])
    }
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
}

