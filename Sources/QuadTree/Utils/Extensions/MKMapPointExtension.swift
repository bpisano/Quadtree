//
//  File.swift
//  QuadTree
//
//  Created by Benjamin Pisano on 01/10/2024.
//

import Foundation
import MapKit

extension MKMapPoint: QuadTreePoint {
    public var coordinateX: Double { x }
    public var coordinateY: Double { y }

    public init(coordinateX: Double, coordinateY: Double) {
        self.init(
            x: coordinateX,
            y: coordinateY
        )
    }
}
