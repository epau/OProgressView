//
//  CGPoint+PointOnEllipse.swift
//  OProgressView
//
//  Created by Edward Paulosky on 2/2/17.
//  Copyright © 2017 epau. All rights reserved.
//

import UIKit

extension CGPoint {
  // Angle is in radians
  static func pointOnEllipse(in rect: CGRect, for angle: CGFloat) -> CGPoint {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let xRadius = rect.width / 2
    let yRadius = rect.height / 2

    return center.pointOnEllipse(angle: angle, xRadius: xRadius, yRadius: yRadius)
  }

  // Angle is in degrees
  static func pointOnEllipse(in rect: CGRect, for angle: Int) -> CGPoint {
    return pointOnEllipse(in: rect, for: CGFloat(angle.degreesToRadians))
  }

  // Angle is in radians
  func pointOnEllipse(angle: CGFloat, xRadius: CGFloat, yRadius: CGFloat) -> CGPoint {
    let x = self.x + xRadius * cos(angle)
    let y = self.y - yRadius * sin(angle)

    return CGPoint(x: x, y: y)
  }
}
