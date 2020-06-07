//
//  Category.swift
//  QuizAppFinal
//
//  Created by five on 06/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

enum Category {
    
    case SPORTS
    case SCIENCE
    
    var color: UIColor {
        switch self {
        case .SPORTS:
            return .red
        case .SCIENCE:
            return .green
        }
    }

}
