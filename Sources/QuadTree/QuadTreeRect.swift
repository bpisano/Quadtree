//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

public protocol QuadTreeRect {
    associatedtype Point: QuadTreePoint

    var rectOrigin: Point { get }
    var rectWidth: Double { get }
    var rectHeight: Double { get }

    init(point: Point, width: Double, height: Double)
    init(x: Double, y: Double, width: Double, height: Double)

    func contains(point: Point) -> Bool
    func intersects(with rect: Self) -> Bool
}
