//
//  Score.swift
//  QuizAppFinal
//
//  Created by five on 22/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

class Score {
    
    let username: String
    let time: Float
    
    init?(json: Any) {
        
        if let jsonDict = json as? [String: Any],
            let username = jsonDict["username"] as? String,
            let time = jsonDict["score"] as? Float
        {
            self.username = username
            self.time = time
        }
        else {
            return nil
        }
    }
    
}

