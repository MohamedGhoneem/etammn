import UIKit
import Flutter
import FirebaseCore
import Firebase


@main
@objc class AppDelegate: FlutterAppDelegate , MessagingDelegate{
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
   FirebaseApp.configure()
      if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
      } else {
        let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
      }
      application.registerForRemoteNotifications()

//
//       Messaging.messaging().delegate = self
//           if #available(iOS 10.0, *) {
//               // For iOS 10 display notification (sent via APNS)
//               UNUserNotificationCenter.current().delegate = self
//               let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//               UNUserNotificationCenter.current().requestAuthorization(
//                       options: authOptions,
//                       completionHandler: {_, _ in })
//           }
//           application.registerForRemoteNotifications()
         GeneratedPluginRegistrant.register(with: self)

      // This function registers the desired plugins to be used within a notification background action
//       SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
//           SwiftAwesomeNotificationsPlugin.register(
//             with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)
//           FLTSharedPreferencesPlugin.register(
//             with: registry.registrar(forPlugin: "io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin")!)
//       }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
