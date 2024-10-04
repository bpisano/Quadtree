//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

public final class QuadTreeNode<Element: QuadTreeElement, Rect: QuadTreeRect> where Element.Point == Rect.Point {
    var elements: [Element] {
        get {
            var collectedElements: [Element] = _elements
            if isDivided {
                if let northeast = northeast { collectedElements.append(contentsOf: northeast.elements) }
                if let northwest = northwest { collectedElements.append(contentsOf: northwest.elements) }
                if let southeast = southeast { collectedElements.append(contentsOf: southeast.elements) }
                if let southwest = southwest { collectedElements.append(contentsOf: southwest.elements) }
            }
            return collectedElements
        }
        set {
            _elements = newValue
        }
    }
    var totalElementCount: Int {
        guard isDivided else { return elements.count }
        var count: Int = elements.count
        count += (northeast?.totalElementCount ?? 0)
        count += (northwest?.totalElementCount ?? 0)
        count += (southeast?.totalElementCount ?? 0)
        count += (southwest?.totalElementCount ?? 0)
        return count
    }

    private var boundary: Rect
    private var capacity: Int
    private var _elements: [Element] = []
    private var isDivided: Bool = false

    private var northeast: QuadTreeNode?
    private var northwest: QuadTreeNode?
    private var southeast: QuadTreeNode?
    private var southwest: QuadTreeNode?

    public init(boundary: Rect, capacity: Int) {
        self.boundary = boundary
        self.capacity = capacity
    }

    @discardableResult
    public func insert(_ element: Element) -> Bool {
        guard boundary.contains(point: element.position) else { return false }
        elements.append(element)
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

    public func query(in rect: Rect) -> Set<Element> {
        var found: Set<Element> = Set()
        query(rect: rect, found: &found)
        return found
    }

    private func query(rect: Rect, found: inout Set<Element>) {
        guard boundary.intersects(with: rect) else { return }

        if isDivided {
            northeast?.query(rect: rect, found: &found)
            northwest?.query(rect: rect, found: &found)
            southeast?.query(rect: rect, found: &found)
            southwest?.query(rect: rect, found: &found)
        } else {
            for element in _elements {
                if rect.contains(point: element.position) {
                    found.insert(element)
                }
            }
        }
    }

    private func subdivideIfNeeded() {
        guard !isDivided else { return }
        guard elements.count > capacity else { return }
        subdivide()
    }

    private func subdivide() {
        let x: Double = boundary.rectOrigin.coordinateX
        let y: Double = boundary.rectOrigin.coordinateY
        let w: Double = boundary.rectWidth / 2
        let h: Double = boundary.rectHeight / 2

        let ne: Rect = .init(
            x: x + w / 2,
            y: y - h / 2,
            width: w,
            height: h
        )
        northeast = QuadTreeNode(boundary: ne, capacity: capacity)

        let nw: Rect = .init(
            x: x - w / 2,
            y: y - h / 2,
            width: w,
            height: h
        )
        northwest = QuadTreeNode(boundary: nw, capacity: capacity)

        let se: Rect = .init(
            x: x + w / 2,
            y: y + h / 2,
            width: w,
            height: h
        )
        southeast = QuadTreeNode(boundary: se, capacity: capacity)

        let sw: Rect = .init(
            x: x - w / 2,
            y: y + h / 2,
            width: w,
            height: h
        )
        southwest = QuadTreeNode(boundary: sw, capacity: capacity)

        for element in elements {
            if northeast?.insert(element) == true { continue }
            if northwest?.insert(element) == true { continue }
            if southeast?.insert(element) == true { continue }
            if southwest?.insert(element) == true { continue }
        }

        elements.removeAll()

        isDivided = true
    }

    private func recomposeIfNeeded() {
        guard isDivided else { return }
        guard totalElementCount <= capacity else { return }
        recompose()
    }

    private func recompose() {
        var allElements: [Element] = []

        if let northeast = northeast { allElements.append(contentsOf: northeast.elements) }
        if let northwest = northwest { allElements.append(contentsOf: northwest.elements) }
        if let southeast = southeast { allElements.append(contentsOf: southeast.elements) }
        if let southwest = southwest { allElements.append(contentsOf: southwest.elements) }

        northeast = nil
        northwest = nil
        southeast = nil
        southwest = nil

        for element in allElements {
            insert(element)
        }

        isDivided = false
    }
}
