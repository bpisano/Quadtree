//
//  File.swift
//  Quadtree
//
//  Created by Benjamin Pisano on 05/10/2024.
//

import Foundation

public struct QuadtreeAnchor: Equatable, Hashable, Codable, Sendable {
    public static let topLeading: QuadtreeAnchor = .init(x: 0, y: 0)
    public static let top: QuadtreeAnchor = .init(x: 0.5, y: 0)
    public static let topTrailing: QuadtreeAnchor = .init(x: 1, y: 0)
    public static let leading: QuadtreeAnchor = .init(x: 0, y: 0.5)
    public static let center: QuadtreeAnchor = .init(x: 0.5, y: 0.5)
    public static let trailing: QuadtreeAnchor = .init(x: 1, y: 0.5)
    public static let bottomLeading: QuadtreeAnchor = .init(x: 0, y: 1)
    public static let bottom: QuadtreeAnchor = .init(x: 0.5, y: 1)
    public static let bottomTrailing: QuadtreeAnchor = .init(x: 1, y: 1)

    public let x: Double
    public let y: Double

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}
