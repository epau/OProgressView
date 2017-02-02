//
//  OProgressViewTests.swift
//  OProgressViewTests
//
//  Created by Edward Paulosky on 2/2/17.
//  Copyright © 2017 epau. All rights reserved.
//

import XCTest

@testable import OProgressView

class OProgressViewTests: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testCGPointOnEllipse() {
    let center = CGPoint(x: 229, y: 372)
    let angle = CGFloat(81)
    let xRadius = CGFloat(126)
    let yRadius = CGFloat(217)

    let pointOnEllipse = CGPoint(pointOnEllipseForAngle: angle, center: center, xRadius: xRadius, yRadius: yRadius)
    let expectedPoint = CGPoint(x: 326.8624337, y: 508.6856947)

    let result = floor(expectedPoint.x * 1000) == floor(pointOnEllipse.x * 1000) && floor(expectedPoint.y * 1000) == floor(pointOnEllipse.y * 1000)
    XCTAssert(result, "Calculated point should equal expected value")
  }
}
