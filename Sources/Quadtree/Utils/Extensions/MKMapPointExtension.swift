//
//  File.swift
//  Quadtree
//
//  Created by Benjamin Pisano on 01/10/2024.
//

#if canImport(MapKit)
import MapKit

extension MKMapPoint: QuadtreePoint {
    public var coordinateX: Double { x }
    public var coordinateY: Double { y }

    public init(coordinateX: Double, coordinateY: Double) {
        self.init(
            x: coordinateX,
            y: coordinateY
        )
    }
}

extension MKMapPoint: @retroactive @unchecked Sendable { }
#endif
