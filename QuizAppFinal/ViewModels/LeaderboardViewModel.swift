//
//  LeaderboardViewModel.swift
//  QuizAppFinal
//
//  Created by five on 18/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation

struct LeaderboardCellModel {
    
    let username: String
    let time: Float
    
    init(score: Score) {
        self.username = score.username
        self.time = score.time
    }
}

class LeaderboardViewModel {
    
    var scores: [Score]?
    var quiz: Quiz? = nil
        
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    
    func getData(urlString: String, completion: @escaping (() -> Void))  {
        
        LeaderboardService().getData(urlString: urlString) { [weak self] (scores) in
            self?.scores = scores
            
            completion()
        }
    }
    
    /*
    func viewModel(atIndex index: Int) -> SingleQuizViewModel? {
        if let quizzes = quizzes {
            if index >= 0 && index < quizzes.count {
                return SingleQuizViewModel(quiz: quizzes[index])
            }
        }
        return nil
    }
    */

    func score(atIndex index: Int) -> LeaderboardCellModel? {
        if let scores = scores {
            return LeaderboardCellModel(score: scores[index])
        }
        
        return nil
    }
    
}
