//
//  File.swift
//  Quadtree
//
//  Created by Benjamin Pisano on 01/10/2024.
//

#if canImport(MapKit)
import MapKit

extension MKMapRect: QuadtreeRect {
    public var rectOrigin: MKMapPoint { origin }
    public var rectWidth: Double { size.width }
    public var rectHeight: Double { size.height }

    public init(
        x: Double,
        y: Double,
        width: Double,
        height: Double
    ) {
        self.init(
            origin: MKMapPoint(
                x: x,
                y: y
            ),
            size: MKMapSize(
                width: width,
                height: height
            )
        )
    }

    public init(
        point: MKMapPoint,
        width: Double,
        height: Double
    ) {
        self.init(
            origin: point,
            size: MKMapSize(
                width: width,
                height: height
            )
        )
    }

    public func contains(point: MKMapPoint) -> Bool {
        contains(point)
    }

    public func intersects(with rect: MKMapRect) -> Bool {
        intersects(rect)
    }
}

extension MKMapRect: @retroactive @unchecked Sendable { }
#endif
