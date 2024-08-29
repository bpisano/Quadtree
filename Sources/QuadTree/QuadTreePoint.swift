//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

public protocol QuadTreePoint {
    var coordinateX: Double { get }
    var coordinateY: Double { get }

    init(coordinateX: Double, coordinateY: Double)
}
