//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation
import Quadtree

struct TestElement: QuadtreeElement {
    let id: Int
    let position: CGPoint

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(position.x)
        hasher.combine(position.y)
    }
}

extension TestElement: CustomDebugStringConvertible {
    var debugDescription: String {
        "(\(position.x) \(position.y))"
    }
}
