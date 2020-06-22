//
//  QuizService.swift
//  QuizAppFinal
//
//  Created by five on 06/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

class QuizService {
    
    func fetchQuiz(completion: @escaping (([Quiz]?) -> Void)){
        
        let stringURL = "https://iosquiz.herokuapp.com/api/quizzes"
        
        if let url = URL(string: stringURL) {
            
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) {
                data, response, error in
                if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        var quizzes = [Quiz]()
                        if let jsonDict = json as? [String: Any],
                            let elements = jsonDict["quizzes"] as? [Any] {
                                for quiz in elements {
                                    if let q = Quiz.createFrom(json: quiz) {
                                        quizzes.append(q)
                                    }
                                }
                            completion(quizzes)
                        }
                        else {
                            completion(nil)
                        }
                    }
                    catch {
                        completion(nil)
                    }
                }
                else {
                    completion(nil)
                }
            }.resume()
        }
        else {
            completion(nil)
        }
    }
}
