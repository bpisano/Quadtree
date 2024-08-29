//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import CoreLocation

extension CLLocationCoordinate2D: QuadTreePoint {
    public var coordinateX: Double { longitude }
    public var coordinateY: Double { latitude }

    public init(coordinateX: Double, coordinateY: Double) {
        self.init(
            latitude: coordinateX,
            longitude: coordinateY
        )
    }
}

extension QuadTreePoint where Self == CLLocationCoordinate2D {
    static func clLocationCoordinate2D(
        latitude: Double,
        longitude: Double
    ) -> Self {
        .init(
            latitude: latitude,
            longitude: longitude
        )
    }
}
