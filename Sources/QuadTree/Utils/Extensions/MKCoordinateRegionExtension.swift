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

    public func contains(point: CLLocationCoordinate2D) -> Bool {
        let minX = rectOrigin.longitude
        let maxX = rectOrigin.longitude + rectWidth
        let minY = rectOrigin.latitude
        let maxY = rectOrigin.latitude + rectHeight

        return point.longitude >= minX && point.longitude <= maxX &&
        point.latitude >= minY && point.latitude <= maxY
    }

    public func intersects(with rect: MKCoordinateRegion) -> Bool {
        let minX1 = rectOrigin.longitude
        let maxX1 = rectOrigin.longitude + rectWidth
        let minY1 = rectOrigin.latitude
        let maxY1 = rectOrigin.latitude + rectHeight

        let minX2 = rect.rectOrigin.longitude
        let maxX2 = rect.rectOrigin.longitude + rect.rectWidth
        let minY2 = rect.rectOrigin.latitude
        let maxY2 = rect.rectOrigin.latitude + rect.rectHeight

        return !(minX1 > maxX2 || maxX1 < minX2 || minY1 > maxY2 || maxY1 < minY2)
    }
}
