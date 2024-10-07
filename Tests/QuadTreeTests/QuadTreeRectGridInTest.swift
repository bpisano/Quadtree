//
//  File.swift
//  QuadTree
//
//  Created by Benjamin Pisano on 07/10/2024.
//

import XCTest
import QuadTree

final class QuadTreeRectGridInTest: XCTestCase {
    func testGridTopLeading() {
        let rect: TestRectTopLeading = .init(x: 0, y: 0, width: 10, height: 10)
        let filterRect: TestRectTopLeading = .init(x: 0, y: 0, width: 2, height: 2)
        let grid: [TestRectTopLeading] = rect.grid(of: 10, by: 10, in: filterRect)
        XCTAssertEqual(grid, [
            .init(x: 0, y: 0, width: 1, height: 1),
            .init(x: 1, y: 0, width: 1, height: 1),
            .init(x: 2, y: 0, width: 1, height: 1),
            .init(x: 0, y: 1, width: 1, height: 1),
            .init(x: 1, y: 1, width: 1, height: 1),
            .init(x: 2, y: 1, width: 1, height: 1),
            .init(x: 0, y: 2, width: 1, height: 1),
            .init(x: 1, y: 2, width: 1, height: 1),
            .init(x: 2, y: 2, width: 1, height: 1),
        ])
    }
}
