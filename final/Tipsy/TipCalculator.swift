//
//  TipCalculator.swift
//  Tipsy
//
//  Created by Alex Brown on 02/07/2020.
//  Copyright © 2020 ABrown. All rights reserved.
//

import Foundation

class TipCalculator {
  private(set) var billAmount = 1000.0
  private(set) var tipPercentage = 15.0
  private let allowedCharacterSet = "0123456789.,"

  private var tipAmount: Double {
    return (billAmount / 100) * tipPercentage
  }

  private var billTotal: Double {
    return billAmount + tipAmount
  }

  var billAmountCurrencyString: String {
    return "\(billAmount.currencyFormatted() ?? "0")"
  }

  var billAmountString: String {
    return "\(billAmount)"
  }

  var tipPercentageString: String {
    return String(format: "%.0f", tipPercentage)
  }

  var tipAmountString: String {
    return "\(tipAmount.currencyFormatted() ?? "0")"
  }

  var billTotalString: String {
    return "\(billTotal.currencyFormatted() ?? "0")"
  }

  /**
    Sets the `billAmount` from a String value, it supports currency strings, strings with separators and plain number String. For example:
    ```
    // The following String formats are supported
    "10000.0" // Numbers
    "10,000"  // Separator
    "£10,000" // Currency
    ```
    - parameter totalString: The string representation of the bill amount, usually coming from a user input via `UITextField`
  */
  func setBillAmount(_ totalString: String ) {
    if totalString.isEmpty {
      billAmount = 0
      return
    }

    if let total = Double(totalString) {
      billAmount = total
    } else if let total = totalString.numberFromCurrencyFormatting()?.doubleValue {
      billAmount = total
    } else if let total = totalString.numberFromSeparatorFormatting()?.doubleValue {
      billAmount = total
    }
  }

  func setTip(_ totalString: String) {
    if totalString.isEmpty {
      setTip(0)
      return
    }

    guard let tip = Double(totalString)
      else { return }

    if tip > 100 {
      setTip(100)
    } else {
      setTip(tip)
    }
  }

  func setTip(_ tip: Double) {
    tipPercentage = tip
  }

  /// Checks to see if the provided `String` is a number or decimal
  /// - parameter str: The `String` value to check against
  /// - returns: `true` if `str` is in the allowed set of characters
  func isCharacterAllowed(_ str: String) -> Bool {
    return allowedCharacterSet.contains(str) || str.isEmpty
  }
}
