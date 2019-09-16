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


    // MARK: - Properties

    var hour = 7
    var minute = 0
    var notificationsOn = true
    var notifyDays = [ true, true, true, true, true, true, true ]

    // MARK: - Outlets

    @IBOutlet var dayButtons: [UIButton]!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var timePicker: UIDatePicker!

    // MARK: - View controller lifecycle


    // MARK: - Actions


    // MARK: - Helpers


}
