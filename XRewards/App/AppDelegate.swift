import GoogleSignIn
import UIKit
import UserNotifications

#if canImport(FirebaseAuth)
import FirebaseAuth
#endif

#if canImport(FirebaseMessaging)
import FirebaseMessaging
#endif

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        #if canImport(FirebaseMessaging)
        Messaging.messaging().delegate = self
        #endif

        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        #if canImport(FirebaseMessaging)
        Messaging.messaging().apnsToken = deviceToken
        #endif
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("⚠️ [XRewards] APNs registration failed: \(error.localizedDescription)")
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

#if canImport(FirebaseMessaging)
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken, !fcmToken.isEmpty else { return }
        #if canImport(FirebaseAuth)
        if Auth.auth().currentUser != nil {
            print("📱 [XRewards] FCM token ready for signed-in user")
        }
        #endif
    }
}
#endif

extension AppDelegate: UNUserNotificationCenterDelegate {}
