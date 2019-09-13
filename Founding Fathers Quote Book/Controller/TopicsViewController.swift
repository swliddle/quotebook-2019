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
        static let showQuoteSegueIdentifier = "ShowQuote"
        static let topicCellIdentifier = "TopicCell"
    }

    // MARK: - Properties

    var selectedTopic: String?

    // MARK: - View controller lifecycle

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let quoteViewController = segue.destination as? QuoteViewController {
            quoteViewController.topic = selectedTopic
        }
    }

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
        selectedTopic = QuoteDeck.sharedInstance.tagSet[indexPath.row]
        performSegue(withIdentifier: Storyboard.showQuoteSegueIdentifier, sender: self)
    }

}
