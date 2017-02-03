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
    let rect = CGRect(x: 229, y: 372, width: 252, height: 434)
    let angle = 81

    let pointOnEllipse = CGPoint.pointOnEllipse(in: rect, for: angle)
    let expectedPoint = CGPoint(x: 374.710, y: 374.671)

    let result = floor(expectedPoint.x * 1000) == floor(pointOnEllipse.x * 1000) && floor(expectedPoint.y * 1000) == floor(pointOnEllipse.y * 1000)
    XCTAssert(result, "Calculated point should equal expected value")
  }

  func testBezierPathOvalSegmentWithPercentage() {
    let rect = CGRect(x: 229, y: 372, width: 252, height: 434)
    let percentage = CGFloat(0.72)

    let path = UIBezierPath(ovalSegmentInRect: rect, percentage: percentage)

    let expectedPoint = CGPoint(x: 231.753, y: 634.116)
    let lastPoint = path.currentPoint

    let result = floor(expectedPoint.x * 1000) == floor(lastPoint.x * 1000) && floor(expectedPoint.y * 1000) == floor(lastPoint.y * 1000)
    XCTAssert(result, "Last point should equal expected value")
  }
}
