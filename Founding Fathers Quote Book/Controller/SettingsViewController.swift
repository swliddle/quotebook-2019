//
//  SettingsViewController.swift
//  Founding Fathers Quote Book
//
//  Created by Steve Liddle on 9/16/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    // MARK: - Constants

    private struct Color {
        static let disabled = UIColor.clear
        static let enabled = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
    }

    private struct NotificationAlert {
        static let buttonLabel = "OK"
        static let message = """
                            To allow this app to remind you of the quote of the day, please
                            go to the Settings app and enable notifications for the Quotes
                            app.
                            """
        static let title = "Notifications Are Disabled"
    }

    private struct NotificationContent {
        static let body = "Read advice from our Founding Fathers."
        static let identifier = "edu.byu.ffqb"
        static let subtitle = "Quote of the Day"
        static let title = "Founding Fathers"
    }

    private enum Settings: String {
        case notificationsOn, hour, minute, notifyDays
    }

    // MARK: - Properties

    var hour = 7
    var minute = 0
    var notificationsOn = true
    var notifyDays = [ true, true, true, true, true, true, true ]

    // MARK: - Computed properties

    private var notificationContent: UNMutableNotificationContent {
        let content = UNMutableNotificationContent()

        content.title = NotificationContent.title
        content.subtitle = NotificationContent.subtitle
        content.body = NotificationContent.body

        return content
    }

    private var notificationTrigger: UNNotificationTrigger {
        var components = DateComponents()

        components.hour = hour
        components.minute = minute

        return UNCalendarNotificationTrigger(dateMatching: components,
                                             repeats: true)
    }

    // MARK: - Outlets

    @IBOutlet var dayButtons: [UIButton]!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var timePicker: UIDatePicker!

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        checkNotificationPermissions()
        restoreSettings()
        updateUI()
    }

    // MARK: - Actions

    @IBAction func toggleNotifications(_ sender: UISwitch) {
        notificationsOn = sender.isOn
        saveSettings()
    }

    @IBAction func updateNotificationTime(_ sender: UIDatePicker) {
        hour = sender.calendar.component(.hour, from: sender.date)
        minute = sender.calendar.component(.minute, from: sender.date)
        saveSettings()
    }
    @IBAction func toggleDay(_ sender: UIButton) {
        notifyDays[sender.tag] = !notifyDays[sender.tag]
        saveSettings()
        updateUI()
    }
    
    // MARK: - Helpers

    private func checkNotificationPermissions() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in

            if settings.authorizationStatus != .authorized {
                let alertController = UIAlertController(title: NotificationAlert.title,
                                                        message: NotificationAlert.message,
                                                        preferredStyle: .alert)

                alertController.addAction(UIAlertAction(title: NotificationAlert.buttonLabel,
                                                        style: .default))

                self.present(alertController, animated: true)
            }
        }
    }

    private func registerNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        if notificationsOn {
            let request = UNNotificationRequest(identifier: NotificationContent.identifier,
                                                content: notificationContent,
                                                trigger: notificationTrigger)

            UNUserNotificationCenter.current().add(request)
        }
    }

    private func restoreSettings() {
        let defaults = UserDefaults.standard

        if let days = defaults.array(forKey: Settings.notifyDays.rawValue) as? [Bool] {
            notifyDays = days
            notificationsOn = defaults.bool(forKey: Settings.notificationsOn.rawValue)
            hour = defaults.integer(forKey: Settings.hour.rawValue)
            minute = defaults.integer(forKey: Settings.minute.rawValue)
        }
    }

    private func saveSettings() {
        let defaults = UserDefaults.standard

        defaults.set(notificationsOn, forKey: Settings.notificationsOn.rawValue)
        defaults.set(hour, forKey: Settings.hour.rawValue)
        defaults.set(minute, forKey: Settings.minute.rawValue)
        defaults.set(notifyDays, forKey: Settings.notifyDays.rawValue)

        defaults.synchronize()
        registerNotifications()
    }

    private func updateUI() {
        notificationsSwitch.setOn(notificationsOn, animated: false)

        let date = timePicker.calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) ?? Date()

        timePicker.setDate(date, animated: false)

        for button in dayButtons {
            button.backgroundColor = notifyDays[button.tag] ? Color.enabled : Color.disabled
        }
    }

}
