//
//  String+StipCurrencyFormat.swift
//  TipCalculator
//
//  Created by Alex Brown on 03/07/2020.
//  Copyright © 2020 ABrown. All rights reserved.
//

import Foundation

extension String {
  /**
    Constructs a `NumberFormatter`, returns an `NSNumber` if the `String` is of format `.currency`, otherwise returns nil.
    - returns: An unformatted instance of NSNumber or nil
  */
  func numberFromCurrencyFormatting() -> NSNumber? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter.number(from: self)
  }

  /**
    Constructs a `NumberFormatter`, returns an `NSNumber` if the `String` is of format `.currency`
    with no currency symbol, otherwise returns nil.
    - returns: An unformatted instance of NSNumber or nil
  */
  func numberFromSeparatorFormatting() -> NSNumber? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = ""
    return formatter.number(from: self)
  }
}
