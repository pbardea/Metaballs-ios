//
//  Size.swift
//  Metaballs
//
//  Created by Paul Bardea on 2017-04-29.
//  Copyright © 2017 pbardea. All rights reserved.
//

import Foundation
import UIKit

//MARK: exponent operator
precedencegroup ExponentiativePrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator ^^: ExponentiativePrecedence
func ^^ (radix: Double, power: Double) -> Double {
    return Double(pow(radix, power))
}



//MARK: Color
extension UIColor {
    static func random() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}

