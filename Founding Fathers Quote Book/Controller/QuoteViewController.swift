//
//  QuoteViewController.swift
//  Founding Fathers Quote Book
//
//  Created by Steve Liddle on 9/12/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import UIKit
import WebKit

class QuoteViewController: UIViewController {

    // MARK: - Constants

    private struct Storyboard {
        static let quoteOfTheDayTitle = "Quote of the Day"
    }

    // MARK: - Properties

    var currentQuoteIndex = 0
    var quotes: [Quote]!
    var topic: String?

    // MARK: - Outlets

    @IBOutlet weak var webView: WKWebView!

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    // MARK: - Actions

    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            currentQuoteIndex -= 1

            if currentQuoteIndex < 0 {
                currentQuoteIndex = quotes.count - 1
            }
        } else {
            currentQuoteIndex += 1

            if currentQuoteIndex >= quotes.count {
                currentQuoteIndex = 0
            }
        }

        updateUIByToggling()
    }
    
    // MARK: - Helpers

    private func chooseQuoteOfTheDay() {
        let formatter = DateFormatter()

        formatter.dateFormat = "DDD"

        if let dayInYear = Int(formatter.string(from: Date())) {
            currentQuoteIndex = dayInYear % QuoteDeck.sharedInstance.quotes.count
        }
    }

    private func configure() {
        if let currentTopic = topic {
            currentQuoteIndex = 0
            quotes = QuoteDeck.sharedInstance.quotes(for: currentTopic)
        } else {
            quotes = QuoteDeck.sharedInstance.quotes
            chooseQuoteOfTheDay()
        }

        updateUI()
    }

    private func title(for topic: String) -> String {
        return "\(topic.capitalized) (\(currentQuoteIndex + 1) of \(quotes.count))"
    }

    private func updateUI() {
        let currentQuote = quotes[currentQuoteIndex]

        if let currentTopic = topic {
            title = title(for: currentTopic)
        } else {
            title = Storyboard.quoteOfTheDayTitle
        }

        webView.loadHTMLString(currentQuote.html, baseURL: nil)
    }

    private func updateUIByToggling() {
        let quote = quotes[currentQuoteIndex]

        if let currentTopic = topic {
            // See http://bit.ly/2ctUdTI

            let fadeTextAnimation = CATransition()

            fadeTextAnimation.duration = 0.75
            fadeTextAnimation.type = .fade

            navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
            navigationItem.title = title(for: currentTopic)
        }

        webView.evaluateJavaScript("toggleQuote('\(quote.text)', '\(quote.speaker)')")
    }

    // MARK: - Segues

    @IBAction func exitModalScene(_ segue: UIStoryboardSegue) {
        // In this case, this is nothing to do, but we need a target
        topic = nil
        configure()
    }

    @IBAction func showTopicQuotes(_ segue: UIStoryboardSegue) {
        configure()
    }
}
