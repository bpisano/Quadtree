//
//  File.swift
//  Quadtree
//
//  Created by Benjamin Pisano on 01/10/2024.
//

#if canImport(MapKit)
import MapKit

extension MKCoordinateRegion: QuadtreeRect {
    public var rectOrigin: CLLocationCoordinate2D { center }
    public var rectWidth: Double { span.longitudeDelta }
    public var rectHeight: Double { span.latitudeDelta }
    public var rectAnchor: QuadtreeAnchor { .center }

    public init(
        x: Double,
        y: Double,
        width: Double,
        height: Double
    ) {
        let centerLatitude = y
        let centerLongitude = x
        let spanLatitude = height
        let spanLongitude = width

        self.init(
            center: CLLocationCoordinate2D(
                latitude: centerLatitude,
                longitude: centerLongitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: spanLatitude,
                longitudeDelta: spanLongitude
            )
        )
    }
}

extension MKCoordinateRegion: @retroactive @unchecked Sendable { }
#endif
