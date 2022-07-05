import UIKit
import MobileCoreServices
import Foundation


@objc(Hello)
class Hello : CDVPlugin {
	var commandCallback: String?

	@objc(sayHello:)
	func sayHello (command: CDVInvokedUrlCommand) {//this method will be called web app
		self.commandCallback = command.callbackId

		let accept = command.arguments.first as! String
		
		let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: “Hello there”)
		self.commandDelegate.send(result, callbackId: command.callbackId)
	}
	
}

