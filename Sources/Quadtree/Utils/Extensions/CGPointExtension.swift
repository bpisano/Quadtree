//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

#if canImport(CoreGraphics)
import CoreGraphics

extension CGPoint: QuadtreePoint {
    public var coordinateX: Double { x }
    public var coordinateY: Double { y }

    public init(coordinateX: Double, coordinateY: Double) {
        self.init(x: coordinateX, y: coordinateY)
    }
}

public extension QuadtreePoint where Self == CGPoint {
    static func cgPoint(x: CGFloat, y: CGFloat) -> Self {
        .init(x: x, y: y)
    }
}

extension CGPoint: @retroactive @unchecked Sendable {}
#endif
