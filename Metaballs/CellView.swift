//
//  CellView.swift
//  Metaballs
//
//  Created by Paul Bardea on 2017-04-29.
//  Copyright © 2017 pbardea. All rights reserved.
//

import UIKit

class CellView: UIView {
    
    var cell: Grid.Cell
    var points = [Point]()
    
    init(cell: Grid.Cell) {
        self.cell = cell
        let dim = CGRect(r: self.cell.dim())
        super.init(frame: dim)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    enum Axis {
        case x, y
    }
    
    func interpolate(a: Grid.Corner, b: Grid.Corner, axis: Axis) -> Point? {
        let isAActive = a.val >= 1
        let isBActive = b.val >= 1
        guard (isAActive != isBActive) else { return nil }
        let density = max(abs(a.x - b.x), abs(a.y - b.y))
        let add = ((1-a.val)/(b.val - a.val)) * density
        switch axis {
        case .x:
            return Point(x: Double(a.x) + add, y: Double(a.y))
        case .y:
            return Point(x: Double(a.x), y: Double(a.y) + add)
        }
    }

    
    func update() {
        self.layer.sublayers = nil
        
        let tl = self.cell.corners[0]
        let tr = self.cell.corners[1]
        let bl = self.cell.corners[2]
        let br = self.cell.corners[3]

        
        let t = interpolate(a: tl, b: tr, axis: .x)
        let l = interpolate(a: tl, b: bl, axis: .y)
        let r = interpolate(a: tr, b: br, axis: .y)
        let b = interpolate(a: bl, b: br, axis: .x)
        
        var points = [t, l, b, r]
        
        if (tl.val >= 1 && bl.val >= 1 && tr.val < 1 && br.val < 1) { // Special case
            points = [l, b, r, t]
        }
        
        // Filters out all `nil` elements
        self.points = points.flatMap { $0 }
        
        for i in (0..<(self.points.count/2)) {
            let first = CGPoint(x: self.points[2 * i].x - tl.x, y: self.points[2 * i].y - tl.y)
            let second = CGPoint(x: self.points[2 * i + 1].x - tl.x, y: self.points[2 * i + 1].y - tl.y)
            
            self.addLine(fromPoint: first, toPoint: second)
        }
        
    }
    
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.blue.cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.layer.addSublayer(line)
    }

}
