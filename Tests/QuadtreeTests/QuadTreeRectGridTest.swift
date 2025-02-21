//
//  File.swift
//  Quadtree
//
//  Created by Benjamin Pisano on 07/10/2024.
//

import XCTest
import Quadtree
import MapKit

final class QuadtreeRectGridTest: XCTestCase {
    func testGridTopLeading() {
        let rect: TestRectTopLeading = .init(x: 0, y: 0, width: 10, height: 10)
        let grid: [TestRectTopLeading] = rect.grid(of: 2, by: 2)
        XCTAssertEqual(grid[0].rectOrigin, .init(x: 0, y: 0))
        XCTAssertEqual(grid[1].rectOrigin, .init(x: 5, y: 0))
        XCTAssertEqual(grid[2].rectOrigin, .init(x: 0, y: 5))
        XCTAssertEqual(grid[3].rectOrigin, .init(x: 5, y: 5))
    }

    func testGridCenter() {
        let rect: TestRectCenter = .init(x: 5, y: 5, width: 10, height: 10)
        let grid: [TestRectCenter] = rect.grid(of: 2, by: 2)
        XCTAssertEqual(grid[0].rectOrigin, .init(x: 2.5, y: 2.5))
        XCTAssertEqual(grid[1].rectOrigin, .init(x: 7.5, y: 2.5))
        XCTAssertEqual(grid[2].rectOrigin, .init(x: 2.5, y: 7.5))
        XCTAssertEqual(grid[3].rectOrigin, .init(x: 7.5, y: 7.5))
    }

    func testGridBottomTrailing() {
        let rect: TestRectBottomTrailing = .init(x: 10, y: 10, width: 10, height: 10)
        let grid: [TestRectBottomTrailing] = rect.grid(of: 2, by: 2)
        XCTAssertEqual(grid[0].rectOrigin, .init(x: 5, y: 5))
        XCTAssertEqual(grid[1].rectOrigin, .init(x: 10, y: 5))
        XCTAssertEqual(grid[2].rectOrigin, .init(x: 5, y: 10))
        XCTAssertEqual(grid[3].rectOrigin, .init(x: 10, y: 10))
    }

    func testCoordinateRegion() {
        let region: MKCoordinateRegion = .init(x: 5, y: 5, width: 10, height: 10)
        let grid: [MKCoordinateRegion] = region.grid(of: 2, by: 2)
        XCTAssertEqual(grid[0].rectOrigin, .init(coordinateX: 2.5, coordinateY: 2.5))
        XCTAssertEqual(grid[1].rectOrigin, .init(coordinateX: 2.5, coordinateY: 7.5))
        XCTAssertEqual(grid[2].rectOrigin, .init(coordinateX: 7.5, coordinateY: 2.5))
        XCTAssertEqual(grid[3].rectOrigin, .init(coordinateX: 7.5, coordinateY: 7.5))
    }
}
