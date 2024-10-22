import Flutter
import UIKit

public class PinAppChallengePostSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "pin_app_challenge_post_sdk", binaryMessenger: registrar.messenger())
    let instance = PinAppChallengePostSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getComments":
      if let args = call.arguments as? [String: Any], let postId = args["postId"] as? Int {
        fetchComments(for: postId, result: result)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func fetchComments(for postId: Int, result: @escaping FlutterResult) {
    APIService.shared.fetchComments(for: postId) { comments in
      if let comments = comments {
          let postList = comments.map { 
            ["id": $0.id, 
            "postId": $0.postId, 
            "name": $0.name, 
            "email": $0.email,
             "body": $0.body] 
          }
          result(postList)
      } else {
          result(nil)
      }
    }
  }
}
