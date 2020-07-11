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

import UIKit

class TipCalculatorViewController: UITableViewController {
  var tipCalculator = TipCalculator()

  @IBOutlet weak var billAmountTextField: UITextField!
  @IBOutlet weak var tipPercentageTextField: UITextField!
  @IBOutlet weak var tipAmountLabel: UILabel!
  @IBOutlet weak var billAmountLabel: UILabel!
  @IBOutlet weak var tipPercentageStepper: UIStepper!
  @IBOutlet weak var keyboardAccessory: UIView!

  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Tip Calculator"

    configureTextFields()
    updateBillAmount()
    updateTotals()
  }

  func configureTextFields() {
    billAmountTextField.inputAccessoryView = keyboardAccessory
    tipPercentageTextField.inputAccessoryView = keyboardAccessory
    billAmountTextField.delegate = self
    tipPercentageTextField.delegate = self
  }

  func updateTotals() {
    tipAmountLabel.text = tipCalculator.tipAmountString
    billAmountLabel.text = tipCalculator.billTotalString
  }

  func updateTipPercentage() {
    tipPercentageTextField.text = tipCalculator.tipPercentageString
  }

  /// Updates the UIStepper with the latest value from tipCalculator
  func updateTipStepperValue() {
    tipPercentageStepper.value = tipCalculator.tipPercentage
  }

  func updateBillAmount() {
    billAmountTextField.text = tipCalculator.billAmountCurrencyString
  }

  // MARK: IBOutlets
  @IBAction func doneEditing() {
    billAmountTextField.resignFirstResponder()
    tipPercentageTextField.resignFirstResponder()

    updateBillAmount()
    updateTotals()
    updateTipPercentage()
  }

  @IBAction func tipPercentageStepperValueChanged(_ sender: UIStepper) {
    tipCalculator.setTip(sender.value)
    updateTipPercentage()
    updateTotals()
  }
}

// MARK: UITextFieldDelegate
extension TipCalculatorViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == billAmountTextField {
      textField.text = tipCalculator.billAmountString
    }
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard
      tipCalculator.isCharacterAllowed(string),
      let text = textField.text,
      let textRange = Range(range, in: text)
      else { return false }

    let updatedText = text.replacingCharacters(in: textRange, with: string)

    if textField == tipPercentageTextField {
      tipCalculator.setTip(updatedText)
      updateTipStepperValue()
    } else {
      tipCalculator.setBillAmount(updatedText)
    }

    updateTotals()
    return true
  }

  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    tipCalculator.setBillAmount("0")
    updateTotals()
    return true
  }
}
