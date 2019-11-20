import Flutter
import UIKit
import Bugly

public class SwiftFlutterBuglyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_bugly_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterBuglyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     if(call.method == "setUp"){
        let arguments = call.arguments as! NSDictionary
        let appID = arguments["app_id"] as! String
        Bugly.start(withAppId: appID)
        result(0)
    } else if(call.method == "postException"){
        let arguments = call.arguments as! NSDictionary
        let message = arguments["crash_message"] as! String
        let detail = arguments["crash_detail"] as! NSString
        let stack = detail.components(separatedBy: "\n")
        Bugly.reportException(withCategory: 4, name:message, reason: stack[0], callStack: stack,extraInfo: [:], terminateApp: false)
        result(0)
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
}
