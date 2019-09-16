//
//  AppDelegate.swift
//  Founding Fathers Quote Book
//
//  Created by Steve Liddle on 9/12/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    // MARK: - Constants

    private struct Application {
        static let version = 1
        static let versionKey = "version"
    }

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - Application life cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (_, _) in
            // Ignore: nothing to do
        }

        window?.makeKeyAndVisible()

        return true
    }

    func application(_ application: UIApplication,
                     shouldRestoreApplicationState coder: NSCoder) -> Bool {

        let version = coder.decodeInteger(forKey: Application.versionKey)

        return version == Application.version
    }

    func application(_ application: UIApplication,
                     shouldSaveApplicationState coder: NSCoder) -> Bool {

        coder.encode(Application.version, forKey: Application.versionKey)

        return true
    }

    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        window?.makeKeyAndVisible()

        return true
    }

    // MARK: - User notification center delegate

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        segueToQuoteOfTheDay()
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        segueToQuoteOfTheDay()
        completionHandler(UNNotificationPresentationOptions())
    }

    // MARK: - Helpers

    private func segueToQuoteOfTheDay() {
        if let navVC = window?.rootViewController as? UINavigationController {
            navVC.dismiss(animated: true)

            if let quoteVC = navVC.viewControllers.first as? QuoteViewController {
                quoteVC.showQuoteOfTheDay()
            }
        }
    }
}

