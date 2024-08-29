import XCTest
import QuadTree

final class quad_treeTests: XCTestCase {
    func testInsertion() {
        let boundary = CGRect(x: 0, y: 0, width: 10, height: 10)
        let quadTree = QuadTree<TestElement, CGRect>(boundary: boundary, capacity: 4)

        let elements = [
            TestElement(id: 1, position: CGPoint(x: 1, y: 1)),
            TestElement(id: 2, position: CGPoint(x: 2, y: 2)),
            TestElement(id: 3, position: CGPoint(x: 3, y: 3)),
            TestElement(id: 4, position: CGPoint(x: 4, y: 4)),
            TestElement(id: 5, position: CGPoint(x: 5, y: 5))
        ]

        for element in elements {
            XCTAssertTrue(quadTree.insert(element))
        }

        let queryRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        let foundElements = quadTree.query(in: queryRect)
        XCTAssertEqual(foundElements.count, elements.count)
    }

    func testQuery() {
        let boundary = CGRect(x: 0, y: 0, width: 10, height: 10)
        let quadTree = QuadTree<TestElement, CGRect>(boundary: boundary, capacity: 4)

        let elements = [
            TestElement(id: 1, position: CGPoint(x: 1, y: 1)),
            TestElement(id: 2, position: CGPoint(x: 2, y: 2)),
            TestElement(id: 3, position: CGPoint(x: 3, y: 3)),
            TestElement(id: 4, position: CGPoint(x: 4, y: 4)),
            TestElement(id: 5, position: CGPoint(x: 5, y: 5))
        ]

        for element in elements {
            XCTAssertTrue(quadTree.insert(element))
        }

        let queryRect = CGRect(x: 0, y: 0, width: 3, height: 3)
        let foundElements = quadTree.query(in: queryRect)
        XCTAssertEqual(foundElements.count, 2)
        XCTAssertEqual(foundElements.map(\.id), [2, 1])
    }

    func testRemove() {
        let boundary = CGRect(x: 0, y: 0, width: 10, height: 10)
        let quadTree = QuadTree<TestElement, CGRect>(boundary: boundary, capacity: 4)

        let elements = [
            TestElement(id: 1, position: CGPoint(x: 1, y: 1)),
            TestElement(id: 2, position: CGPoint(x: 2, y: 2)),
            TestElement(id: 3, position: CGPoint(x: 3, y: 3))
        ]

        for element in elements {
            XCTAssertTrue(quadTree.insert(element))
        }

        let elementToRemove = TestElement(id: 2, position: CGPoint(x: 2, y: 2))
        XCTAssertTrue(quadTree.remove(elementToRemove))

        let queryRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        let foundElements = quadTree.query(in: queryRect)
        XCTAssertEqual(foundElements.count, 2)
        XCTAssertFalse(foundElements.contains { $0.id == elementToRemove.id })
    }
}
