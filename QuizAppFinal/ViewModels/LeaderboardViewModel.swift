//
//  LeaderboardViewModel.swift
//  QuizAppFinal
//
//  Created by five on 18/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation

struct LeaderboardCellModel {
    
    let title: String
    let description: String
    let level: Int
    let category: Category
    let imageUrl: URL?
    
    init(quiz: Quiz) {
        self.title = quiz.title
        self.description = quiz.description
        self.level = quiz.level
        self.category = quiz.category
        self.imageUrl = URL(string: quiz.image)
    }
}

class LeaderboardViewModel {
    
    var quizzes: Any?
    
    func getData(urlString: String, completion: @escaping (() -> Void))  {
        
        let leaderboardService = LeaderboardService()
        
        leaderboardService.getData(urlString: urlString) { [weak self] (quizzes) in
            self?.quizzes = quizzes
            
            print(quizzes!)
            
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

    func quiz(atIndex index: Int) -> QuizCellModel? {
        guard let quizzes = quizzes else {
            return nil
        }
        
        let quizCellModel = QuizCellModel(quiz: quizzes[index])
        return quizCellModel
    }
    
    func numberOfQuizzes() -> Int {
        return quizzes?.count ?? 0
    }
    */
    
}
