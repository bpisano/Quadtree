//
//  File.swift
//  Quadtree
//
//  Created by Benjamin Pisano on 05/10/2024.
//

import XCTest
@testable import Quadtree

final class QuadtreeAnchorTests: XCTestCase {
    func testTopLeading() async {
        let boundary = TestRectTopLeading(x: 0, y: 0, width: 10, height: 10)
        let quadTree = Quadtree<TestElement, TestRectTopLeading>(boundary: boundary, capacity: 4)

        let elements = [
            TestElement(id: 1, position: CGPoint(x: 1, y: 1)),
            TestElement(id: 2, position: CGPoint(x: 2, y: 2)),
            TestElement(id: 3, position: CGPoint(x: 3, y: 3)),
            TestElement(id: 4, position: CGPoint(x: 4, y: 4)),
            TestElement(id: 5, position: CGPoint(x: 5, y: 5))
        ]

        for element in elements {
            let result: Bool = await quadTree.insert(element)
            XCTAssertTrue(result)
        }

        let foundElements = await quadTree.query(in: boundary)
        XCTAssertEqual(foundElements.count, elements.count)
    }

    func testCenter() async {
        let boundary = TestRectCenter(x: 5, y: 5, width: 10, height: 10)
        let quadTree = Quadtree<TestElement, TestRectCenter>(boundary: boundary, capacity: 4)

        let elements = [
            TestElement(id: 1, position: CGPoint(x: 1, y: 1)),
            TestElement(id: 2, position: CGPoint(x: 2, y: 2)),
            TestElement(id: 3, position: CGPoint(x: 3, y: 3)),
            TestElement(id: 4, position: CGPoint(x: 4, y: 4)),
            TestElement(id: 5, position: CGPoint(x: 5, y: 5))
        ]

        for element in elements {
            let result: Bool = await quadTree.insert(element)
            XCTAssertTrue(result)
        }

        let foundElements = await quadTree.query(in: boundary)
        XCTAssertEqual(foundElements.count, elements.count)
    }

    func testBottomTrailing() async {
        let boundary = TestRectBottomTrailing(x: 10, y: 10, width: 10, height: 10)
        let quadTree = Quadtree<TestElement, TestRectBottomTrailing>(boundary: boundary, capacity: 4)

        let elements = [
            TestElement(id: 1, position: CGPoint(x: 1, y: 1)),
            TestElement(id: 2, position: CGPoint(x: 2, y: 2)),
            TestElement(id: 3, position: CGPoint(x: 3, y: 3)),
            TestElement(id: 4, position: CGPoint(x: 4, y: 4)),
            TestElement(id: 5, position: CGPoint(x: 5, y: 5))
        ]

        for element in elements {
            let result: Bool = await quadTree.insert(element)
            XCTAssertTrue(result)
        }

        let foundElements = await quadTree.query(in: boundary)
        XCTAssertEqual(foundElements.count, elements.count)
    }
}
