//
//  SingleQuizViewModel.swift
//  QuizAppFinal
//
//  Created by five on 09/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation

class SingleQuizViewModel {
    var quiz: Quiz? = nil
        
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    
    var title: String {
        return quiz?.title ?? ""
    }
    
    var imageUrl: URL? {
        if let urlString = quiz?.image {
            return URL(string: urlString)
        }
        return nil
    }
}
