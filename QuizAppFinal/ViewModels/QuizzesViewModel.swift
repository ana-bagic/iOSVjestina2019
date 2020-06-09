//
//  QuizViewModel.swift
//  QuizAppFinal
//
//  Created by five on 09/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation

struct QuizCellModel {
    
    let title: String
    let description: String
    let level: Int
    let imageUrl: URL?
    
    init(quiz: Quiz) {
        self.title = quiz.title
        self.description = quiz.description
        self.level = quiz.level
        self.imageUrl = URL(string: quiz.image)
    }
}

class QuizzesViewModel {
    
    var quizzes: [Quiz]?
    
    func fetchQuiz(completion: @escaping (() -> Void))  {
        
        let quizService = QuizService()
        
        quizService.fetchQuiz { [weak self] (quizzes) in
            self?.quizzes = quizzes
            completion()
        }
    }
    
    // viewModel pruza metode preko kojih se dohvacaju drugi viewModeli koje ce drugi ViewControlleri koristiti
    /*
    func viewModel(atIndex index: Int) -> SingleReviewViewModel? {
        if let reviews = reviews {
            if index >= 0 && index < reviews.count {
                return SingleReviewViewModel(review: reviews[index])
            }
        }
        return nil
    }
    */

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
    
    // Metoda viewModela koju poziva viewController koja je zaduzena za stvaranje novog Reviewa (propagiranje promjene modela)
    /*
    func createReview(withText title: String, date: String, summary: String) -> Void {
        let review = Review(title: title, date: date, summary: summary)
        
        // teoretsko pozivanje servisa koji stvara model na serveru i pri povratku sa servera stvara model u bazi podataka
        ReviewsService().createReview(review) { success in
            NepoznataBazaPodataka.store(review)
        }
        reviews?.append(review)
    }
     */
}
