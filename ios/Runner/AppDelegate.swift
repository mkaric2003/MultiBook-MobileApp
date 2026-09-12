import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if let googleMapsAPIKey = Bundle.main.object(
      forInfoDictionaryKey: "GoogleMapsAPIKey"
    ) as? String,
      !googleMapsAPIKey.isEmpty,
      !googleMapsAPIKey.hasPrefix("$(")
    {
      GMSServices.provideAPIKey(googleMapsAPIKey)
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
