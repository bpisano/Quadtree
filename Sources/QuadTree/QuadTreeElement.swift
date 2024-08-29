//
//  File.swift
//  
//
//  Created by Benjamin Pisano on 29/08/2024.
//

import Foundation

public protocol QuadTreeElement: Hashable {
    associatedtype Point: QuadTreePoint

    var position: Point { get }
}
