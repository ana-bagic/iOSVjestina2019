//
//  ImageService.swift
//  QuizAppFinal
//
//  Created by five on 06/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

/*
import Foundation
import UIKit

class ImageService {
    
    func fetchImage(urlString: String, completion: @escaping ((UIImage?) -> Void)){
        
        if let url = URL(string: urlString) {

            URLSession.shared.dataTask(with: url) {
                (data, response, error) in

                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
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
*/
