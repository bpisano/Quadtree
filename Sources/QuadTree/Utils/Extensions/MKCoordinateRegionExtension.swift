//
//  File.swift
//  QuadTree
//
//  Created by Benjamin Pisano on 01/10/2024.
//

import Foundation
import MapKit

extension MKCoordinateRegion: QuadTreeRect {
    public var rectOrigin: CLLocationCoordinate2D {
        .init(
            latitude: center.latitude - span.latitudeDelta / 2,
            longitude: center.longitude - span.longitudeDelta / 2
        )
    }
    public var rectWidth: Double { span.longitudeDelta }
    public var rectHeight: Double { span.latitudeDelta }
    public var rectAnchor: QuadTreeAnchor { .center }

    public init(
        x: Double,
        y: Double,
        width: Double,
        height: Double
    ) {
        let centerLatitude = y + height / 2
        let centerLongitude = x + width / 2
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

    public init(point: CLLocationCoordinate2D, width: Double, height: Double) {
        let centerLatitude = point.latitude + height / 2
        let centerLongitude = point.longitude + width / 2

        self.init(
            center: CLLocationCoordinate2D(
                latitude: centerLatitude,
                longitude: centerLongitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: height,
                longitudeDelta: width
            )
        )
    }
}
