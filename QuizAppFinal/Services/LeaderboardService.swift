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
    
    func getData(urlString: String, completion: @escaping ((Any?) -> Void)){
        
        if let url = URL(string: urlString) {
            
            let parameters: [String: Any] = ["quiz_id": 4]
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
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            }
            catch {
                completion(nil)
            }
            
            URLSession.shared.dataTask(with: url) {
                data, response, error in
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
            }.resume()
        }
        else {
            completion(nil)
        }
    }
}
