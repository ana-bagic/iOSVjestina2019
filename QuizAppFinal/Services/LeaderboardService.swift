//
//  LeaderboardService.swift
//  QuizAppFinal
//
//  Created by five on 18/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardService {
    
    func getData(urlString: String, completion: @escaping (([Score]?) -> Void)){
        
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            let userDefaults = UserDefaults.standard
            print(userDefaults.string(forKey: "token")!)
            print(userDefaults.string(forKey: "username")!)
            print(userDefaults.string(forKey: "user_id")!)
            if let token = userDefaults.string(forKey: "token") {
                request.addValue(token, forHTTPHeaderField: "Authorization")
            }
            
            URLSession.shared.dataTask(with: request) {
                data, response, error in
                if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        var scores = [Score]()
                        if let jsonDict = json as? [Any] {
                            for score in jsonDict {
                                if let s = Score(json: score) {
                                    scores.append(s)
                                }
                            }
                            completion(scores)
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
