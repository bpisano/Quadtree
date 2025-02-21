//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

@QuadtreeActor
public final class Quadtree<Element: QuadtreeElement, Rect: QuadtreeRect> where Element.Point == Rect.Point {
    private nonisolated let root: QuadtreeNode<Element, Rect>

    public nonisolated init(boundary: Rect, capacity: Int) {
        root = QuadtreeNode(boundary: boundary, capacity: capacity)
    }

    @discardableResult
    public func insert(_ element: Element) -> Bool {
        root.insert(element)
    }

    @discardableResult
    public func remove(_ element: Element) -> Bool where Element: Equatable {
        root.remove(element)
    }

    public func removeAll(where match: (_ element: Element) throws -> Bool) rethrows {
        try root.removeAll(where: match)
    }

    public func removeAll() {
        root.removeAll()
    }

    public func query(in rect: Rect) -> [Element] {
        root.query(in: rect)
    }
}

extension Quadtree: @preconcurrency CustomDebugStringConvertible {
    public var debugDescription: String {
        "Quadtree\n\(root.debugDescription)"
    }
}
