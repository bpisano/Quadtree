import XCTest
import Quadtree

final class QuadtreeActionsTests: XCTestCase {
    func testInsertion() async {
        let boundary = CGRect(x: 0, y: 0, width: 10, height: 10)
        let quadTree = Quadtree<TestElement, CGRect>(boundary: boundary, capacity: 4)

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

        let queryRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        let foundElements = await quadTree.query(in: queryRect)
        XCTAssertEqual(foundElements.count, elements.count)
    }

    func testQuery() async {
        let boundary = CGRect(x: 0, y: 0, width: 10, height: 10)
        let quadTree = Quadtree<TestElement, CGRect>(boundary: boundary, capacity: 4)

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

        let queryRect = CGRect(x: 0, y: 0, width: 3, height: 3)
        let foundElements = await quadTree.query(in: queryRect)
        XCTAssertEqual(foundElements.count, 2)
        XCTAssertEqual(foundElements.map(\.id).sorted(), [1, 2])
    }

    func testRemove() async {
        let boundary = CGRect(x: 0, y: 0, width: 10, height: 10)
        let quadTree = Quadtree<TestElement, CGRect>(boundary: boundary, capacity: 4)

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

        let elementToRemove = TestElement(id: 2, position: CGPoint(x: 2, y: 2))
        let removeResult: Bool = await quadTree.remove(elementToRemove)
        XCTAssertTrue(removeResult)

        let queryRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        let foundElements = await quadTree.query(in: queryRect)
        XCTAssertEqual(foundElements.count, 4)
        XCTAssertFalse(foundElements.contains { $0.id == elementToRemove.id })
    }
}
