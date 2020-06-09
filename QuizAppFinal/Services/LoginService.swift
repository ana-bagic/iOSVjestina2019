//
//  LoginService.swift
//  QuizAppFinal
//
//  Created by five on 09/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

class LoginService {
    
    func login(username: String, password: String, completion: @escaping ((Any?) -> Void)){

        let stringURL = "https://iosquiz.herokuapp.com/api/session"
        
        if let url = URL(string: stringURL) {
            
            let parameters: [String: Any] = ["username": username, "password": password]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            
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
