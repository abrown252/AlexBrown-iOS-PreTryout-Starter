//
//  Double+Rounded.swift
//  Tipsy
//
//  Created by Alex Brown on 03/07/2020.
//  Copyright © 2020 ABrown. All rights reserved.
//

import Foundation

extension Double {
  ///  Constructs a `NumberFormatter`, returns a currency formatted `String` or nil. For example, the number 10000 would return "$10,000"
  ///  - returns: A currency formatted `String` or nil if the conversion fails
  func currencyFormatted() -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter.string(from: NSNumber(value: self))
  }
}
