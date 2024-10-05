//
//  File.swift
//  QuadTree
//
//  Created by Benjamin Pisano on 05/10/2024.
//

import Foundation

public struct QuadTreeAnchor: Equatable, Hashable, Codable, Sendable {
    public static let topLeading: QuadTreeAnchor = .init(x: 0, y: 0)
    public static let top: QuadTreeAnchor = .init(x: 0.5, y: 0)
    public static let topTrailing: QuadTreeAnchor = .init(x: 1, y: 0)
    public static let leading: QuadTreeAnchor = .init(x: 0, y: 0.5)
    public static let center: QuadTreeAnchor = .init(x: 0.5, y: 0.5)
    public static let trailing: QuadTreeAnchor = .init(x: 1, y: 0.5)
    public static let bottomLeading: QuadTreeAnchor = .init(x: 0, y: 1)
    public static let bottom: QuadTreeAnchor = .init(x: 0.5, y: 1)
    public static let bottomTrailing: QuadTreeAnchor = .init(x: 1, y: 1)

    public let x: Double
    public let y: Double

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}
