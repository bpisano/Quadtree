//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

@QuadtreeActor
public final class QuadtreeNode<Element: QuadtreeElement, Rect: QuadtreeRect> where Element.Point == Rect.Point {
    private nonisolated let boundary: Rect
    private nonisolated let capacity: Int
    private var elements: [Element] = []
    private var isDivided: Bool = false

    private var northeast: QuadtreeNode?
    private var northwest: QuadtreeNode?
    private var southeast: QuadtreeNode?
    private var southwest: QuadtreeNode?

    public nonisolated init(boundary: Rect, capacity: Int) {
        self.boundary = boundary
        self.capacity = capacity
    }

    @discardableResult
    public func insert(_ element: Element) -> Bool {
        guard boundary.contains(point: element.position) else { return false }

        if isDivided {
            if let northeast, northeast.insert(element) { return true }
            if let northwest, northwest.insert(element) { return true }
            if let southeast, southeast.insert(element) { return true }
            if let southwest, southwest.insert(element) { return true }
            return false
        } else {
            elements.append(element)
        }

        subdivideIfNeeded()

        return true
    }

    @discardableResult
    public func remove(_ element: Element) -> Bool where Element: Equatable {
        guard boundary.contains(point: element.position) else { return false }

        if isDivided {
            if northeast?.remove(element) == true ||
                northwest?.remove(element) == true ||
                southeast?.remove(element) == true ||
                southwest?.remove(element) == true {
                recomposeIfNeeded()
                return true
            }
        } else if let index = elements.firstIndex(where: { $0 == element }) {
            elements.remove(at: index)
            recomposeIfNeeded()
            return true
        }

        return false
    }

    public func removeAll(where match: (_ element: Element) throws -> Bool) rethrows {
        if isDivided {
            try northeast?.removeAll(where: match)
            try northwest?.removeAll(where: match)
            try southeast?.removeAll(where: match)
            try southwest?.removeAll(where: match)
            recomposeIfNeeded()
        } else {
            try elements.removeAll(where: match)
        }
    }

    public func removeAll() {
        if isDivided {
            northeast?.removeAll()
            northwest?.removeAll()
            southeast?.removeAll()
            southwest?.removeAll()
            recomposeIfNeeded()
        } else {
            elements = []
        }
    }

    public func query(in rect: Rect) -> [Element] {
        var found: [Element] = []
        query(rect: rect, found: &found)
        return found
    }

    private func query(rect: Rect, found: inout [Element]) {
        guard boundary.intersects(with: rect) else { return }

        if isDivided {
            northeast?.query(rect: rect, found: &found)
            northwest?.query(rect: rect, found: &found)
            southeast?.query(rect: rect, found: &found)
            southwest?.query(rect: rect, found: &found)
        } else {
            elements
                .filter { rect.contains(point: $0.position) }
                .forEach { element in
                    found.append(element)
                }
        }
    }

    private func subdivideIfNeeded() {
        guard !isDivided else { return }
        guard elements.count > capacity else { return }
        subdivide()
    }

    private func subdivide() {
        let halfWidth: Double = boundary.rectWidth / 2
        let halfHeight: Double = boundary.rectHeight / 2

        let ne: Rect = .init(
            x: boundary.topLeadingX + halfWidth * boundary.rectAnchor.x,
            y: boundary.topLeadingY + halfHeight * boundary.rectAnchor.y,
            width: halfWidth,
            height: halfHeight
        )

        let nw: Rect = .init(
            x: ne.rectOrigin.coordinateX + halfWidth,
            y: ne.rectOrigin.coordinateY,
            width: halfWidth,
            height: halfHeight
        )

        let sw: Rect = .init(
            x: nw.rectOrigin.coordinateX,
            y: nw.rectOrigin.coordinateY + halfHeight,
            width: halfWidth,
            height: halfHeight
        )

        let se: Rect = .init(
            x: ne.rectOrigin.coordinateX,
            y: ne.rectOrigin.coordinateY + halfHeight,
            width: halfWidth,
            height: halfHeight
        )

        northeast = QuadtreeNode(boundary: ne, capacity: capacity)
        northwest = QuadtreeNode(boundary: nw, capacity: capacity)
        southeast = QuadtreeNode(boundary: se, capacity: capacity)
        southwest = QuadtreeNode(boundary: sw, capacity: capacity)

        for element in elements {
            if northeast?.insert(element) == true { continue }
            if northwest?.insert(element) == true { continue }
            if southeast?.insert(element) == true { continue }
            if southwest?.insert(element) == true { continue }
        }

        elements = []

        isDivided = true
    }

    private func recomposeIfNeeded() {
        guard isDivided else { return }
        guard let northeast, let northwest, let southeast, let southwest else { return }
        guard !northeast.isDivided, !northwest.isDivided, !southeast.isDivided, !southwest.isDivided else { return }

        let childElements: [Element] = northeast.elements + northwest.elements + southeast.elements + southwest.elements

        if childElements.count <= capacity {
            recompose(with: childElements)
        }
    }

    private func recompose(with childElements: [Element]) {
        northeast = nil
        northwest = nil
        southeast = nil
        southwest = nil

        elements = childElements

        isDivided = false
    }
}

extension QuadtreeNode: @preconcurrency CustomDebugStringConvertible {
    public var debugDescription: String {
        var result: String = "\(boundary) \(elements.count) elements"

        if !elements.isEmpty {
            result += "\n  Elements: \(elements)"
        }

        if isDivided {
            result += "\n  NE: \(northeast?.debugDescription.indented(by: 4) ?? "nil")"
            result += "\n  NW: \(northwest?.debugDescription.indented(by: 4) ?? "nil")"
            result += "\n  SE: \(southeast?.debugDescription.indented(by: 4) ?? "nil")"
            result += "\n  SW: \(southwest?.debugDescription.indented(by: 4) ?? "nil")"
        }

        return result
    }
}
