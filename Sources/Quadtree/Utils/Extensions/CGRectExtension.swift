//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

#if canImport(CoreGraphics)
import CoreGraphics

extension CGRect: QuadtreeRect {
    public var rectOrigin: CGPoint { origin }
    public var rectWidth: Double { width }
    public var rectHeight: Double { height }

    public init(
        point: CGPoint,
        width: Double,
        height: Double
    ) {
        self.init(
            origin: point,
            size: .init(
                width: width,
                height: height
            )
        )
    }

    public func contains(point: CGPoint) -> Bool {
        contains(point)
    }

    public func intersects(with rect: CGRect) -> Bool {
        intersects(rect)
    }
}

public extension QuadtreeRect where Self == CGRect {
    static func cgRect(
        origin: CGPoint,
        size: CGSize
    ) -> Self {
        .init(origin: origin, size: size)
    }

    static func cgRect(
        x: CGFloat,
        y: CGFloat,
        width: CGFloat,
        height: CGFloat
    ) -> Self {
        .init(
            x: x,
            y: y,
            width: width,
            height: height
        )
    }
}

extension CGRect: @retroactive @unchecked Sendable { }
#endif
