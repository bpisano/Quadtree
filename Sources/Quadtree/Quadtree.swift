//
//  File.swift
//
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

/// A spatial partitioning data structure that recursively subdivides a space into quadrants to efficiently store and query 2D data points.
///
/// The Quadtree class provides methods for inserting, removing and querying elements in a two-dimensional space.
/// It uses a tree structure where each node can have up to four children representing subdivided quadrants.
///
/// Example usage:
/// ```swift
/// let boundary = CGRect(x: 0, y: 0, width: 100, height: 100)
/// let quadtree = Quadtree(boundary: boundary, capacity: 4)
///
/// // Insert a point
/// let point = CGPoint(x: 10, y: 10)
/// await quadtree.insert(point)
///
/// // Query points in a region
/// let queryRect = CGRect(x: 0, y: 0, width: 50, height: 50)
/// let points = await quadtree.query(in: queryRect)
/// ```
@QuadtreeActor
public final class Quadtree<Element: QuadtreeElement, Rect: QuadtreeRect>
where Element.Point == Rect.Point {
    private nonisolated let root: QuadtreeNode<Element, Rect>

    /// Creates a new Quadtree instance.
    /// - Parameters:
    ///   - boundary: The rectangular boundary that defines the total space covered by this quadtree
    ///   - capacity: The maximum number of elements that can be stored in a single node before it subdivides
    public nonisolated init(boundary: Rect, capacity: Int) {
        root = QuadtreeNode(boundary: boundary, capacity: capacity)
    }

    /// Inserts an element into the quadtree.
    /// - Parameter element: The element to insert
    /// - Returns: `true` if the element was successfully inserted, `false` otherwise
    @discardableResult
    public func insert(_ element: Element) -> Bool {
        root.insert(element)
    }

    /// Removes a specific element from the quadtree.
    /// - Parameter element: The element to remove
    /// - Returns: `true` if the element was found and removed, `false` otherwise
    @discardableResult
    public func remove(_ element: Element) -> Bool where Element: Equatable {
        root.remove(element)
    }

    /// Removes all elements that satisfy the given predicate.
    /// - Parameter match: A closure that takes an element and returns `true` if the element should be removed
    public func removeAll(where match: (_ element: Element) throws -> Bool) rethrows {
        try root.removeAll(where: match)
    }

    /// Removes all elements from the quadtree.
    public func removeAll() {
        root.removeAll()
    }

    /// Queries the quadtree for all elements within a given rectangular region.
    /// - Parameter rect: The rectangular region to query
    /// - Returns: An array of elements that fall within the query region
    public func query(in rect: Rect) -> [Element] {
        root.query(in: rect)
    }
}

extension Quadtree: @preconcurrency CustomDebugStringConvertible {
    public var debugDescription: String {
        "Quadtree\n\(root.debugDescription)"
    }
}
