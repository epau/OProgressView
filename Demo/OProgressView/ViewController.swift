//
//  ViewController.swift
//  OProgressView
//
//  Created by Edward Paulosky on 2/2/17.
//  Copyright © 2017 epau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var oProgressView: OProgressView!

  override func viewDidLoad() {
    super.viewDidLoad()

    let frame = CGRect(x: 40, y: 40, width: 280, height: 280)
    oProgressView = OProgressView(frame: frame)
    oProgressView.progressLabel.font = UIFont.systemFont(ofSize: 32)
    view.addSubview(oProgressView)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    oProgressView.setProgress(0, animated: false)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.oProgressView.setProgress(0.80, animated: true)
  }
}

