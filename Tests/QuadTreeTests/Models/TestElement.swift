//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation
import QuadTree

struct TestElement: QuadTreeElement {
    let id: Int
    let position: CGPoint

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(position.x)
        hasher.combine(position.y)
    }
}
