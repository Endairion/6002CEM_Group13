import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyA36o5GXvW4Kauogfmfgqnas7oBMzUqmkU")
    GeneratedPluginRegistrant.register(with: self)
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app needs access to location when open.</string>
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
