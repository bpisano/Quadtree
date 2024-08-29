//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

public final class QuadTreeNode<Element: QuadTreeElement, Rect: QuadTreeRect> where Element.Point == Rect.Point {
    private var boundary: Rect
    private var capacity: Int
    private var elements: [Element] = []
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
        if !boundary.contains(point: element.position) {
            return false
        }

        if elements.count < capacity {
            elements.append(element)
            return true
        }

        if !isDivided {
            subdivide()
        }

        if let northeast, northeast.insert(element) { return true }
        if let northwest, northwest.insert(element) { return true }
        if let southeast, southeast.insert(element) { return true }
        if let southwest, southwest.insert(element) { return true }

        return false
    }

    @discardableResult
    public func remove(_ element: Element) -> Bool where Element: Equatable {
        if !boundary.contains(point: element.position) {
            return false
        }

        if let index = elements.firstIndex(where: { $0 == element }) {
            elements.remove(at: index)
            recompose()
            return true
        }

        if isDivided {
            if northeast?.remove(element) == true ||
                northwest?.remove(element) == true ||
                southeast?.remove(element) == true ||
                southwest?.remove(element) == true {
                recompose()
                return true
            }
        }

        return false
    }

    public func query(in rect: Rect) -> Set<Element> {
        var found: Set<Element> = Set()
        query(rect: rect, found: &found)
        return found
    }

    private func query(rect: Rect, found: inout Set<Element>) {
        if !boundary.intersects(with: rect) {
            return
        }

        for element in elements {
            if rect.contains(point: element.position) {
                found.insert(element)
            }
        }

        if isDivided {
            northeast?.query(rect: rect, found: &found)
            northwest?.query(rect: rect, found: &found)
            southeast?.query(rect: rect, found: &found)
            southwest?.query(rect: rect, found: &found)
        }
    }

    private func subdivide() {
        guard !isDivided else { return }

        let x: Double = boundary.rectOrigin.coordinateX
        let y: Double = boundary.rectOrigin.coordinateY
        let w: Double = boundary.rectWidth / 2
        let h: Double = boundary.rectHeight / 2

        let ne: Rect = .init(x: x + w, y: y, width: w, height: h)
        northeast = QuadTreeNode(boundary: ne, capacity: capacity)

        let nw: Rect = .init(x: x, y: y, width: w, height: h)
        northwest = QuadTreeNode(boundary: nw, capacity: capacity)

        let se: Rect = .init(x: x + w, y: y + h, width: w, height: h)
        southeast = QuadTreeNode(boundary: se, capacity: capacity)

        let sw: Rect = .init(x: x, y: y + h, width: w, height: h)
        southwest = QuadTreeNode(boundary: sw, capacity: capacity)

        isDivided = true
    }

    private func recompose() {
        guard isDivided else { return }

        var allElements: [Element] = []
        if let northeast = northeast { allElements.append(contentsOf: northeast.elements) }
        if let northwest = northwest { allElements.append(contentsOf: northwest.elements) }
        if let southeast = southeast { allElements.append(contentsOf: southeast.elements) }
        if let southwest = southwest { allElements.append(contentsOf: southwest.elements) }

        northeast = nil
        northwest = nil
        southeast = nil
        southwest = nil
        isDivided = false

        for element in allElements {
            insert(element)
        }
    }
}
