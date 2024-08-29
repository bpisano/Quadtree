//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import CoreGraphics

extension CGPoint: QuadTreePoint {
    public var coordinateX: Double { self.x }
    public var coordinateY: Double { self.y }

    public init(coordinateX: Double, coordinateY: Double) {
        self.init(x: coordinateX, y: coordinateY)
    }
}

public extension QuadTreePoint where Self == CGPoint {
    static func cgPoint(x: CGFloat, y: CGFloat) -> Self {
        .init(x: x, y: y)
    }
}
