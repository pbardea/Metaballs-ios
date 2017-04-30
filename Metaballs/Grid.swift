//
//  Grid.swift
//  Metaballs
//
//  Created by Paul Bardea on 2017-04-29.
//  Copyright © 2017 pbardea. All rights reserved.
//

import Foundation

class Grid {
    
    var shapes = [Shape]()
    var views = [CellView]()
  
    let cells: [[Cell]]
    let density: Double
    
    
    init(density: Double, size: Size) {
        self.density = density
        
        let h = Int(size.height / density)
        let w = Int(size.width / density)
        
        // Initialize all corners
        var corners = [[Corner]]()
        for i in 0...h {
            corners.append([])
            for j in 0...w {
                corners[i].append(Corner(x: Double(j) * density, y: Double(i) * density))
            }
        }
        
        // Initialize cells from corners
        var c = [[Cell]]()
        
        for row in 0..<h {
            c.append([])
            for col in 0..<w {
                var cnrs = [Corner]()
                for i in 0...1 {
                    for j in 0...1 {
                        cnrs.append(corners[row + i][col + j])
                    }
                }
                c[row].append(Cell(corners: cnrs))
            }
        }
        
        self.cells = c
    }
    
    func addShape(c: Shape) {
        self.shapes.append(c)
    }
    
    func update() {
        for row in cells {
            for cell in row {
                cell.update(shapes: shapes)
            }
        }
        for view in self.views {
            view.update()
        }
    }
    
    
    // Internal classes
    
    class Corner {
        var val: Double
        
        let x: Double
        let y: Double
        
        // X and Y are zero-indexed
        init(val: Double, x: Double, y: Double) {
            self.val = val
            self.x = x
            self.y = y
        }
        
        init(x: Double, y: Double) {
            self.val = 0
            self.x = x
            self.y = y
        }
        
        func update(shapes: [Shape]) {
            self.val = 0
            
            let x = self.x
            let y = self.y
            for shape in shapes {
                self.val += shape.function(p: Point(x: x, y: y))
            }
        }
    }
    
    class Cell {
        let corners: [Corner]
        
        init(corners: [Corner]) {
            self.corners = corners
        }
        
        func update(shapes: [Shape]) {
            for corner in corners {
                corner.update(shapes: shapes)
            }
        }
        
        func origin() -> Point {
            let minX = corners.map({$0.x}).min()!
            let minY = corners.map({$0.y}).min()!
            
            return Point(x: Double(minX), y: Double(minY))
        }
        
        func size() -> Size {
            let minX = corners.map({$0.x}).min()!
            let minY = corners.map({$0.y}).min()!
            let maxX = corners.map({$0.x}).max()!
            let maxY = corners.map({$0.y}).max()!
            
            return Size(width: maxX - minX, height: maxY - minY)
        }
        
        func dim() -> Rect {
            return Rect(origin: self.origin(), size: self.size())
        }
    }
    
}
