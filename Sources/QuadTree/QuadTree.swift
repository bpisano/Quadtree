//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

public final class QuadTree<Element: QuadTreeElement, Rect: QuadTreeRect> where Element.Point == Rect.Point {
    private let root: QuadTreeNode<Element, Rect>

    public init(boundary: Rect, capacity: Int) {
        root = QuadTreeNode(boundary: boundary, capacity: capacity)
    }

    @discardableResult
    public func insert(_ element: Element) -> Bool {
        root.insert(element)
    }

    @discardableResult
    public func remove(_ element: Element) -> Bool where Element: Equatable {
        root.remove(element)
    }

    public func query(in rect: Rect) -> Set<Element> {
        root.query(in: rect)
    }
}
