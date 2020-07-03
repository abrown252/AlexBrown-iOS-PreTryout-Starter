//
//  ViewController.swift
//  TipCalculator
//
//  Created by Alex Brown on 02/07/2020.
//  Copyright © 2020 ABrown. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UITableViewController {
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Tip Calculator"
  }
}

// MARK: UITextFieldDelegate
extension TipCalculatorViewController: UITextFieldDelegate {}
