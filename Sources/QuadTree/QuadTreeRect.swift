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
    var rectAnchor: QuadTreeAnchor { get }

    init(point: Point, width: Double, height: Double)
    init(x: Double, y: Double, width: Double, height: Double)

    func contains(point: Point) -> Bool
    func intersects(with rect: Self) -> Bool
}

extension QuadTreeRect {
    var topLeadingX: Double { rectOrigin.coordinateX - rectWidth * rectAnchor.x }
    var topLeadingY: Double { rectOrigin.coordinateY - rectHeight * rectAnchor.y }

    public var rectAnchor: QuadTreeAnchor {
        .topLeading
    }

    public init(point: Point, width: Double, height: Double) {
        self.init(
            x: point.coordinateX,
            y: point.coordinateY,
            width: width,
            height: height
        )
    }

    public func contains(point: Point) -> Bool {
        let minX: Double = topLeadingX
        let maxX: Double = topLeadingX + rectWidth
        let minY: Double = topLeadingY
        let maxY: Double = topLeadingY + rectHeight

        return (minX <= point.coordinateX && point.coordinateX <= maxX) &&
        (minY <= point.coordinateY && point.coordinateY <= maxY)
    }

    public func intersects(with rect: Self) -> Bool {
        let minX1: Double = topLeadingX
        let maxX1: Double = topLeadingX + rectWidth
        let minY1: Double = topLeadingY
        let maxY1: Double = topLeadingY + rectHeight

        let minX2: Double = rect.topLeadingX
        let maxX2: Double = rect.topLeadingX + rect.rectWidth
        let minY2: Double = rect.topLeadingY
        let maxY2: Double = rect.topLeadingY + rect.rectHeight

        return (minX1 <= maxX2 && maxX1 >= minX2) &&
        (minY1 <= maxY2 && maxY1 >= minY2)
    }

    public func grid(of width: Int, by height: Int) -> [Self] {
        guard width > 0, height > 0 else { return [] }

        let subRectWidth: Double = rectWidth / Double(width)
        let subRectHeight: Double = rectHeight / Double(height)

        var grid: [Self] = []

        let startX: Double = topLeadingX
        let startY: Double = topLeadingY

        for row in 0..<height {
            for column in 0..<width {
                let subRectX: Double = startX + Double(column) * subRectWidth
                let subRectY: Double = startY + Double(row) * subRectHeight

                let subRect: Self = .init(
                    x: subRectX + subRectWidth * rectAnchor.x,
                    y: subRectY + subRectHeight * rectAnchor.y,
                    width: subRectWidth,
                    height: subRectHeight
                )

                grid.append(subRect)
            }
        }

        return grid
    }

    public func grid(of width: Int, by height: Int, in rect: Self) -> [Self] {
        guard width > 0, height > 0 else { return [] }

        let subRectWidth: Double = rectWidth / Double(width)
        let subRectHeight: Double = rectHeight / Double(height)

        let startX: Double = topLeadingX
        let startY: Double = topLeadingY

        let minX: Double = rect.topLeadingX
        let maxX: Double = rect.topLeadingX + rect.rectWidth
        let minY: Double = rect.topLeadingY
        let maxY: Double = rect.topLeadingY + rect.rectHeight

        let minColumn: Int = max(0, Int((minX - startX) / subRectWidth))
        let maxColumn: Int = min(width - 1, Int((maxX - startX) / subRectWidth))
        let minRow: Int = max(0, Int((minY - startY) / subRectHeight))
        let maxRow: Int = min(height - 1, Int((maxY - startY) / subRectHeight))

        var grid: [Self] = []

        for row in minRow...maxRow {
            for column in minColumn...maxColumn {
                let subRectX: Double = startX + Double(column) * subRectWidth
                let subRectY: Double = startY + Double(row) * subRectHeight

                let subRect: Self = .init(
                    x: subRectX + subRectWidth * rectAnchor.x,
                    y: subRectY + subRectHeight * rectAnchor.y,
                    width: subRectWidth,
                    height: subRectHeight
                )

                if subRect.intersects(with: rect) {
                    grid.append(subRect)
                }
            }
        }

        return grid
    }
}
