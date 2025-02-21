//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

public protocol QuadtreeElement: Hashable {
    associatedtype Point: QuadtreePoint

    var position: Point { get }
}
