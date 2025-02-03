//
//  AppDelegate.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//


import CoreData
import UIKit
import GoogleMaps
import GooglePlaces
import SideMenuController
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "Menu")!
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelRight
        SideMenuController.preferences.drawing.sidePanelWidth = 250
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .horizontalPan
        SideMenuController.preferences.animating.transitionAnimator = FadeAnimator.self
//      GMSServices.provideAPIKey(GOOGLE_API_KEY)
//     GMSPlacesClient.provideAPIKey(GOOGLE_API_KEY)
//         Override point for customization after application launch.
         Messaging.messaging().subscribe(toTopic: "news")
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        application.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification Allowed.")
            } else {
                print("Notification Not Allowed.")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self
            let autOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: autOptions) { _,_  in
                //
            }
        } else {
            let settings = UIUserNotificationSettings.init(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        fbHandler()
        FirebaseApp.configure()
        registerForPushNotifications()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        //
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func fbHandler() {
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    // MARK: - Push Notifications (Firebase)
    
    
    
    fileprivate let viewActionIdentifier = "VIEW_IDENTIFIER"
    fileprivate let newsCategoryIdentifier = "Glasor"
    
    // Receive Foreground Notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Foreground Notification Received.")
        completionHandler(.alert)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token = \(fcmToken)")
        DataManager.shared.FCMToken = fcmToken
        Messaging.messaging().subscribe(toTopic: "news")
    }
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        Messaging.messaging().subscribe(toTopic: "news")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        fbHandler()
    }
    
    // MARK: - Push Notifications (Pusher)
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permission \(granted).")
            guard granted else { return }
            let viewAction = UNNotificationAction.init(identifier: self.viewActionIdentifier, title: "View", options: [.foreground])
            let newsCategory = UNNotificationCategory.init(identifier: self.newsCategoryIdentifier, actions: [viewAction], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([newsCategory])
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings() { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.sync {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let number = userInfo["articleId"] as! String
        switch application.applicationState {
        case .active:
            print("active")
            completionHandler(.noData)
            break
        case .background:
            if number == "1" {
                completionHandler(.newData)
            }
            print("background")
            
        case .inactive:
            completionHandler(.failed)
            break
        }
    }
    
    
    
    // MARK: - Background fetch data
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //
    }
}












