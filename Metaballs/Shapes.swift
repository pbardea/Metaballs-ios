//
//  Shapes.swift
//  Metaballs
//
//  Created by Paul Bardea on 2017-04-30.
//  Copyright © 2017 pbardea. All rights reserved.
//

import Foundation

protocol Shape {
    func getPos() -> Point
    func setPos(p pont: Point)
    
    func contains(p point: Point) -> Bool
    func function(p point: Point) -> Double
}


class Circle {
    var centre: Point
    let radius: Double = 80
    
    init(x: Int, y: Int) {
        self.centre = Point(x: Double(x), y: Double(y))
    }
    
    init(centre: Point) {
        self.centre = centre
    }
    
    func move(newPoint: Point) {
        self.centre = newPoint
    }
}

extension Circle : Shape {
    func getPos() -> Point {
        return self.centre
    }
    
    func setPos(p point: Point) {
        self.centre = point
    }
    
    func contains(p point: Point) -> Bool {
        return self.centre.dist(p: point) <= radius
    }
    
    func function(p point: Point) -> Double {
        return radius ^^ 2 / ((point.x - centre.x) ^^ 2 + (point.y - centre.y) ^^ 2)
    }
}
