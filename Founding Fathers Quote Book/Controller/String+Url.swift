//
//  String+Url.swift
//  Founding Fathers Quote Book
//
//  Created by Steve Liddle on 9/16/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import Foundation

extension String {
    var url: URL? {
        return URL(string: self)
    }
}
