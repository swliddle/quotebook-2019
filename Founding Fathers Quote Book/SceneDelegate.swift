//
//  SceneDelegate.swift
//  Founding Fathers Quote Book
//
//  Created by Steve Liddle on 9/12/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UNUserNotificationCenterDelegate {

    // MARK: - Properties

    var window: UIWindow?

    // MARK: Scene delegate life cycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }

        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (_, _) in
            // Ignore: nothing to do
        }
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

