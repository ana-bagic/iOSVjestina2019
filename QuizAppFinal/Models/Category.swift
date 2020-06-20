//
//  Category.swift
//  QuizAppFinal
//
//  Created by five on 06/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

enum Category: String {
    
    case SPORTS = "Sports"
    case SCIENCE = "Science"
    
    static var numberOfCat = 2
    
    var color: UIColor {
        switch self {
        case .SPORTS:
            return UIColor.FlatColor.Blue.Mariner ?? .blue
        case .SCIENCE:
            return UIColor.FlatColor.Green.PersianGreen ?? .green
        }
    }

}
