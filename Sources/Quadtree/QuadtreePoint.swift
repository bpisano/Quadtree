//
//  File.swift
//
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

/// A protocol that represents a point in a 2D space.
///
/// The `QuadtreePoint` protocol defines the requirements for a type that represents
/// a point in two-dimensional space. Any type conforming to this protocol must provide:
/// - X and Y coordinates as `Double` values
/// - An initializer that creates a point from X and Y coordinates
public protocol QuadtreePoint: Sendable {
    /// The X coordinate of the point
    var coordinateX: Double { get }

    /// The Y coordinate of the point
    var coordinateY: Double { get }

    /// Creates a new point with the specified coordinates
    /// - Parameters:
    ///   - coordinateX: The X coordinate
    ///   - coordinateY: The Y coordinate
    init(coordinateX: Double, coordinateY: Double)
}
