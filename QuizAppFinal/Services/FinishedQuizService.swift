//
//  FinishedQuizService.swift
//  QuizAppFinal
//
//  Created by five on 17/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

class FinishedQuizService {
    
    func send(quiz: Int, user: String, time: Double, correct: Int, completion: @escaping ((Any?) -> Void)){

        let stringURL = "https://iosquiz.herokuapp.com/api/result"
        
        if let url = URL(string: stringURL) {
            
            let parameters: [String: Any] = ["quiz_id": quiz, "user_id": user, "time": time, "no_of_correct": correct]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            let userDefaults = UserDefaults.standard
            if let token = userDefaults.string(forKey: "token") {
                request.addValue(token, forHTTPHeaderField: "Authorization")
            }
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            }
            catch {
                completion(nil)
            }

            URLSession.shared.dataTask(with: request) {
                (data, response, error) in

                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        completion(json)
                    }
                    catch {
                        completion(nil)
                    }
                }
                else {
                    completion(nil)
                }
            }
            .resume()
        }
        else {
            completion(nil)
        }
    }
}
