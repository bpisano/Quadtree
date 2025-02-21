//
//  File.swift
//
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

/// A protocol that represents an element that can be inserted into a quadtree.
///
/// The `QuadtreeElement` protocol defines the requirements for a type that can be stored
/// in a quadtree data structure. Any type conforming to this protocol must provide:
/// - A position property that returns a `QuadtreePoint` representing its location
/// - Conformance to `Hashable` to enable efficient storage and lookup
///
/// Example usage:
/// ```swift
/// struct MyElement: QuadtreeElement {
///     // Use CGPoint as the position type
///     typealias Point = CGPoint
///
///     // The element's position in 2D space
///     let position: CGPoint
/// }
/// ```
public protocol QuadtreeElement: Hashable {
    /// The type of point used to represent this element's position
    associatedtype Point: QuadtreePoint

    /// The position of this element in 2D space
    var position: Point { get }
}
