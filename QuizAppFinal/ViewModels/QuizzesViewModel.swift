//
//  QuizViewModel.swift
//  QuizAppFinal
//
//  Created by five on 09/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import CoreData

struct QuizCellModel {
    
    let title: String
    let description: String
    let level: Int
    let category: Category
    let imageUrl: URL?
    let id: Int
    
    init(quiz: Quiz) {
        self.title = quiz.title
        self.description = quiz.desc
        self.level = quiz.level
        if (quiz.category == "SPORTS") {
            self.category = .SPORTS
        }
        else {
            self.category = .SCIENCE
        }
        self.imageUrl = URL(string: quiz.image)
        self.id = quiz.id
    }
}

class QuizzesViewModel {
    
    var quizzes: [Quiz]?
    
    // empty CoreData
    /*
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Quiz.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
        try DataController.shared.persistentContainer.viewContext.execute(deleteRequest)
    }
    catch let error as NSError {
        print(error)
    }
     */
    
    func fetchQuizFromData(completion: @escaping (() -> Void))  {
        
        self.quizzes = DataController.shared.fetchQuizzes()
        completion()
        
    }
    
    func fetchQuizFromInternet(completion: @escaping (() -> Void)) {
        
        QuizService().fetchQuiz { [weak self] (quizzes) in
            self?.quizzes = DataController.shared.fetchQuizzes()
            completion()
        }

    }

    func viewModel(atIndex index: Int) -> SingleQuizViewModel? {
        if let quizzes = quizzes {
            if index >= 0 && index < quizzes.count {
                return SingleQuizViewModel(quiz: quizzes[index])
            }
        }
        return nil
    }
    
    func viewModelOfCategory(category: String) -> [SingleQuizViewModel] {
        var returnViewModels: [SingleQuizViewModel] = []
        
        if let quizzes = quizzes {
            for quiz in quizzes {
                if quiz.category == category {
                    returnViewModels.append(SingleQuizViewModel(quiz: quiz))
                }
            }
        }
        
        return returnViewModels
    }
    
    func viewModelForId(id: Int) -> QuizCellModel? {
        if let quizzes = quizzes {
            for i in 0...numberOfQuizzes() - 1 {
                if quizzes[i].id == id {
                    return QuizCellModel(quiz: quizzes[i])
                }
            }
        }
        return nil
    }

    func quizzesOfCategory(category: String) -> [QuizCellModel] {
        var returnQuizzes: [QuizCellModel] = []
        
        if let quizzes = quizzes {
            for quiz in quizzes {
                if quiz.category == category {
                    returnQuizzes.append(QuizCellModel(quiz: quiz))
                }
            }
        }
        
        return returnQuizzes
    }
    
    func quizzesContain(word: String) -> [QuizCellModel] {
        var returnQuizzes: [QuizCellModel] = []
           
        if let quizzes = quizzes {
            for quiz in quizzes {
                if quiz.description.lowercased().contains(word) || quiz.title.lowercased().contains(word) {
                    returnQuizzes.append(QuizCellModel(quiz: quiz))
                }
            }
        }
           
        return returnQuizzes
    }
    
    func numberOfQuizzes() -> Int {
        return quizzes?.count ?? 0
    }
    
}
