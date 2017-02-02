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
    self.init()

    let center = CGPoint(x: rect.midX, y: rect.midY)
    let xRadius = rect.width / 2
    let yRadius = rect.height / 2

    let startDegrees: CGFloat = 90 // 0 is the right most point on an oval, so set to 90 to start at the top.
    let startAngle = startDegrees.degreesToRadians

    let endDegrees = startDegrees - percentage * 360 // subtract to move clockwise

    guard startDegrees - 1 > endDegrees else {
      return
    }

    let firstPoint = CGPoint(pointOnEllipseForAngle: startAngle, center: center, xRadius: xRadius, yRadius: yRadius)
    move(to: firstPoint)

    for degree in stride(from: Int(startDegrees - 1), to: Int(endDegrees - 1), by: -1) {
      let angle = CGFloat(degree).degreesToRadians
      let point = CGPoint(pointOnEllipseForAngle: CGFloat(angle), center: center, xRadius: xRadius, yRadius: yRadius)
      addLine(to: point)
    }
  }
}
