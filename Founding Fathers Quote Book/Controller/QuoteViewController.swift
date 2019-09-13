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

    // MARK: - Properties

    var currentQuoteIndex = 0

    // MARK: - Outlets

    @IBOutlet weak var webView: WKWebView!

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        chooseQuoteOfTheDay()
        updateUI()
    }

    // MARK: - Helpers

    private func chooseQuoteOfTheDay() {
        let formatter = DateFormatter()

        formatter.dateFormat = "DDD"

        if let dayInYear = Int(formatter.string(from: Date())) {
            currentQuoteIndex = dayInYear % QuoteDeck.sharedInstance.quotes.count
        }
    }

    private func updateUI() {
        let currentQuote = QuoteDeck.sharedInstance.quotes[currentQuoteIndex]

        webView.loadHTMLString(currentQuote.html, baseURL: nil)
    }

    // MARK: - Segues

    @IBAction func exitModalScene(_ segue: UIStoryboardSegue) {
        // In this case, this is nothing to do, but we need a target
    }
}
