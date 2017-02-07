//
//  UIBezierPath+Percentage.swift
//  OProgressView
//
//  Created by Edward Paulosky on 2/2/17.
//  Copyright © 2017 epau. All rights reserved.
//

import UIKit

extension UIBezierPath {
  convenience init(ovalSegmentInRect rect: CGRect, percentage: CGFloat) {
    guard percentage > 0, percentage <= 1 else {
      self.init()
      return
    }

    // set to 90 to start at the top of the ellipse
    let angleA = 90

    // subtract to move clockwise
    let angleB = angleA - Int(percentage * 360)

    self.init(ovalSegmentInRect: rect, from: angleA, to: angleB)
  }

  convenience init(ovalSegmentInRect rect: CGRect, from angleA: Int, to angleB: Int) {
    self.init()

    let firstPoint = CGPoint.pointOnEllipse(in: rect, for: angleA)
    move(to: firstPoint)

    addArc(in: rect, from: angleA, to: angleB)
  }

  // Angle A and Angle B are in degrees
  func addArc(in rect: CGRect, from angleA: Int, to angleB: Int) {
    let i = angleA > angleB ? -1 : 1

    for angle in stride(from: angleA, to: angleB + i, by: i) {
      let angleInRadians = angle.degreesToRadians
      let point = CGPoint.pointOnEllipse(in: rect, for: CGFloat(angleInRadians))
      addLine(to: point)
    }
  }
}
