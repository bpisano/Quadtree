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

public extension QuadTreeRect {
    func grid(of width: Int, by height: Int) -> [Self] {
        guard width > 0, height > 0 else { return [] }

        let subRectWidth: Double = rectWidth / Double(width)
        let subRectHeight: Double = rectHeight / Double(height)

        var grid: [Self] = []

        for row in 0..<height {
            for column in 0..<width {
                let subRectX: Double = rectOrigin.coordinateX + Double(column) * subRectWidth
                let subRectY: Double = rectOrigin.coordinateY + Double(row) * subRectHeight

                let subRect: Self = .init(
                    x: subRectX,
                    y: subRectY,
                    width: subRectWidth,
                    height: subRectHeight
                )

                grid.append(subRect)
            }
        }

        return grid
    }
}
