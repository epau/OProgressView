//
//  FloatingPoint+DegreesToRadians.swift
//  OProgressView
//
//  Created by Edward Paulosky on 2/2/17.
//  Copyright © 2017 epau. All rights reserved.
//

import Foundation

extension Int {
  var degreesToRadians: Float {
    return Float(self) * Float.pi / 180
  }
}
