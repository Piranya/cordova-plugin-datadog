import UIKit
import MobileCoreServices
import Foundation


class Hello : CDVPlugin{
@objc(Hello:)
func sayHello(command : CDVInvokedUrlCommand) //this method will be called web app
{
let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: “Hello there”)
self.commandDelegate.send(result, callbackId: command.callbackId)
}
}
