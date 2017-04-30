//
//  GirdBasics.swift
//  Metaballs
//
//  Created by Paul Bardea on 2017-04-30.
//  Copyright © 2017 pbardea. All rights reserved.
//

import Foundation
import UIKit

//MARK: Point
class Point {
    let x: Double
    let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point {
    func scale(factor f: Double) -> Point {
        return Point(x: Double(self.x) * f, y: Double(self.y) * f)
    }
    
    func dist(p point: Point) -> Double {
        let xDist = self.x - point.x
        let yDist = self.y - point.y
        return sqrt(xDist ^^ 2 + yDist ^^ 2)
    }
}

extension CGPoint {
    func mPoint() -> Point {
        return Point(x: Double(self.x), y: Double(self.y))
    }
    
    init(p: Point) {
        self.init(x: p.x, y: p.y)
    }
}

// MARK: Size
class Size {
    let width: Double
    let height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

extension CGSize {
    func mSize() -> Size {
        return Size(width: Double(self.width), height: Double(self.height))
    }
    
    init(s: Size) {
        self.init(width: s.width, height: s.height)
    }
}


// MARK: Rect
class Rect {
    let origin: Point
    let size: Size
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
}

extension CGRect {
    func mRect() -> Rect {
        return Rect(origin: self.origin.mPoint(), size: self.size.mSize())
    }
    
    init(r: Rect) {
        self.init(origin: CGPoint(p: r.origin), size: CGSize(s: r.size))
    }
}
