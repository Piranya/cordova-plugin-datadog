import UIKit
import MobileCoreServices
import Foundation


@objc(Hello)
class Hello : CDVPlugin {
	var commandCallback: String?

	@objc(sayHello:)
	func sayHello (command: CDVInvokedUrlCommand) {//this method will be called web app
		return "hello world from swift plugin"
	}
	
}

