import UIKit
import MobileCoreServices
import Foundation


@objc(Hello)
class Hello : CDVPlugin {
	var commandCallback: String?

	@objc(sayHello:)
	func sayHello (command: CDVInvokedUrlCommand) -> String {
		return "hello world from swift plugin"
	}
	
}

