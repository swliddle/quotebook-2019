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

