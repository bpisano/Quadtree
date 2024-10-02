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

extension QuadTreeRect {
    func grid(of xCount: Int, by yCount: Int) -> [Self] {
        let rectSize: CGSize = .init(
            width: rectWidth / Double(xCount),
            height: rectHeight / Double(yCount)
        )
        var rects: [Self] = []
        for x in 0..<xCount {
            for y in 0..<yCount {
                let rectOrigin: Point = .init(
                    coordinateX: rectOrigin.coordinateX + Double(x) * rectSize.width,
                    coordinateY: rectOrigin.coordinateY + Double(y) * rectSize.height
                )
                let rect: Self = .init(
                    point: rectOrigin,
                    width: rectSize.width,
                    height: rectSize.height
                )
                rects.append(rect)
            }
        }
        return rects
    }
}
