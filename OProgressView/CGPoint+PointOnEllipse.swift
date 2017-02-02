//
//  CGPoint+PointOnEllipse.swift
//  OProgressView
//
//  Created by Edward Paulosky on 2/2/17.
//  Copyright © 2017 epau. All rights reserved.
//

import UIKit

extension CGPoint {
  init(pointOnEllipseForAngle angle: CGFloat, center: CGPoint, xRadius: CGFloat, yRadius: CGFloat) {
    x = center.x + xRadius * cos(angle)
    y = center.y - yRadius * sin(angle)
  }
}
