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
    
    var currentShape: Shape?

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
                if shape.contains(p: location.mPoint()) {
                    self.currentShape = shape
                    shape.setPos(p: location.mPoint())
                    break
                } else {
                    self.currentShape = nil
                }
            }
            if (self.currentShape == nil) {
                self.currentShape = Circle(centre: location.mPoint())
                grid.addShape(c: self.currentShape!)
            }
        }
        grid.update()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { touch in
            let location = touch.location(in: self.view)
            currentShape?.setPos(p: location.mPoint())
        }
        grid.update()
    }
    
    
}
