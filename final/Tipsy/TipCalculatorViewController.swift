//
//  TipCalculatorViewController.swift
//  Tipsy
//
//  Created by Alex Brown on 02/07/2020.
//  Copyright © 2020 ABrown. All rights reserved.
//

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
