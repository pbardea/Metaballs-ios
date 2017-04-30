//
//  MetaballsViewController.swift
//  Metaballs
//
//  Created by Paul Bardea on 2017-04-29.
//  Copyright © 2017 pbardea. All rights reserved.
//

import UIKit

class MetaballsViewController: UIViewController {
    
    var grid: Grid!
    var cellViews = [CellView]()
    
    var currentCircle: Circle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.grid = Grid(density: 5, size: self.view.bounds.size.mSize())
        
        for row in self.grid.cells {
            for cell in row {
                cellViews.append(CellView(cell: cell))
            }
        }
        
        self.grid.views = cellViews
        
        for view in cellViews {
            self.view.addSubview(view)
        }

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { touch in
            let location = touch.location(in: self.view)
            for shape in grid.shapes {
                if location.mPoint().dist(p: shape.centre) <= shape.radius {
                    self.currentCircle = shape
                    shape.centre = location.mPoint()
                    break
                } else {
                    self.currentCircle = nil
                }
            }
            if (self.currentCircle == nil) {
                self.currentCircle = Circle(centre: location.mPoint())
                grid.addShape(c: self.currentCircle!)
            }
        }
        grid.update()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { touch in
            let location = touch.location(in: self.view)
            currentCircle?.move(newPoint: location.mPoint())
        }
        grid.update()
    }
    
    
}
