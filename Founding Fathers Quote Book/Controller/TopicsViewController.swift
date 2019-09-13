//
//  TopicsViewController.swift
//  Founding Fathers Quote Book
//
//  Created by Steve Liddle on 9/13/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import UIKit

class TopicsViewController: UITableViewController {

    // MARK: - Constants

    private struct Storyboard {
        static let topicCellIdentifier = "TopicCell"
    }

    // MARK: - Properties


    // MARK: - View controller lifecycle


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.topicCellIdentifier, for: indexPath)

        cell.textLabel?.text = QuoteDeck.sharedInstance.tagSet[indexPath.row].capitalized

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuoteDeck.sharedInstance.tagSet.count
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User tapped row \(indexPath.row)")
    }

}
