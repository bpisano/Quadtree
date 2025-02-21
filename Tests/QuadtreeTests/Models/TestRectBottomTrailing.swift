//
//  File.swift
//  Quadtree
//
//  Created by Benjamin Pisano on 05/10/2024.
//

import Foundation
import Quadtree

struct TestRectBottomTrailing: QuadtreeRect, Equatable {
    let rectOrigin: CGPoint
    let rectWidth: Double
    let rectHeight: Double
    let rectAnchor: QuadtreeAnchor = .bottomTrailing

    init(point: CGPoint, width: Double, height: Double) {
        rectOrigin = point
        rectWidth = width
        rectHeight = height
    }

    init(x: Double, y: Double, width: Double, height: Double) {
        rectOrigin = .init(x: x, y: y)
        rectWidth = width
        rectHeight = height
    }
}

extension TestRectBottomTrailing: CustomDebugStringConvertible {
    var debugDescription: String {
        "(\(rectOrigin.x) \(rectOrigin.y) \(rectWidth) \(rectHeight))"
    }
}
