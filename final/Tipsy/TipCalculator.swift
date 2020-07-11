/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

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
