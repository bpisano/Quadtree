//
//  File.swift
//  QuadTree
//
//  Created by Benjamin Pisano on 04/10/2024.
//

import Foundation

extension String {
    func indented(by spaces: Int) -> String {
        let padding: String = .init(repeating: " ", count: spaces)
        return split(separator: "\n")
            .map { padding + $0 }
            .joined(separator: "\n")
    }
}
