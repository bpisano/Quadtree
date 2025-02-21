//
//  File.swift
//  Quadtree
//
//  Created by Benjamin Pisano on 05/10/2024.
//

import XCTest
import Quadtree

final class QuadRectContainsTests: XCTestCase {
    func testTopLeadingAnchor() {
        let boundary = TestRectTopLeading(x: 0, y: 0, width: 10, height: 10)
        XCTAssertTrue(boundary.contains(point: .init(x: 0, y: 0)))
        XCTAssertTrue(boundary.contains(point: .init(x: 0, y: 10)))
        XCTAssertTrue(boundary.contains(point: .init(x: 10, y: 0)))
        XCTAssertTrue(boundary.contains(point: .init(x: 10, y: 10)))
    }

    func testCenterAnchor() {
        let boundary = TestRectCenter(x: 5, y: 5, width: 10, height: 10)
        XCTAssertTrue(boundary.contains(point: .init(x: 0, y: 0)))
        XCTAssertTrue(boundary.contains(point: .init(x: 0, y: 10)))
        XCTAssertTrue(boundary.contains(point: .init(x: 10, y: 0)))
        XCTAssertTrue(boundary.contains(point: .init(x: 10, y: 10)))
    }

    func testBottomTrailingAnchor() {
        let boundary = TestRectBottomTrailing(x: 10, y: 10, width: 10, height: 10)
        XCTAssertTrue(boundary.contains(point: .init(x: 0, y: 0)))
        XCTAssertTrue(boundary.contains(point: .init(x: 0, y: 10)))
        XCTAssertTrue(boundary.contains(point: .init(x: 10, y: 0)))
        XCTAssertTrue(boundary.contains(point: .init(x: 10, y: 10)))
    }
}
