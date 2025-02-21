//
//  File.swift
//  Quadtree
//
//  Created by Benjamin Pisano on 05/10/2024.
//

import Foundation
import Quadtree

struct TestRectCenter: QuadtreeRect, Equatable {
    let rectOrigin: CGPoint
    let rectWidth: Double
    let rectHeight: Double
    let rectAnchor: QuadtreeAnchor = .center

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

extension TestRectCenter: CustomDebugStringConvertible {
    var debugDescription: String {
        "(\(rectOrigin.x) \(rectOrigin.y) \(rectWidth) \(rectHeight))"
    }
}
