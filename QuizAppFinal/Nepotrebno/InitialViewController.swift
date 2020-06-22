//
//  InitialViewController.swift
//  QuizAppFinal
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

/*
import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var dohvatiButton: UIButton!
    @IBOutlet weak var odjaviButton: UIButton!
    @IBOutlet weak var ffLabel: UILabel!
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    var customView: UIView?
    
    @IBAction func fetchButton(_ sender: Any) {
        fetchQuiz()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "token")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchQuiz() {
        
        let quizService = QuizService()
        
        quizService.fetchQuiz() { (quizzes) in
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    
                    var nba: [Question] = []
                    var NBAcount = 0
                    
                    for element in quizzes {
                        nba = element.questions.filter { $0.question.contains("NBA")}
                        NBAcount += nba.count
                    }
                    
                    self.ffLabel.text = "FUN FACT: U kvizu ima \(NBAcount) pitanja koja sadrže riječ NBA"
                    
                    let x = Int.random(in: 0..<3)
                    self.quizNameLabel.backgroundColor = quizzes[x].category.color
                    self.quizNameLabel.text = quizzes[x].title
                    self.quizImageView.backgroundColor = quizzes[x].category.color
                    
                    let imageService = ImageService()
                    imageService.fetchImage(urlString: quizzes[x].image) { (image) in
                        DispatchQueue.main.async {
                            if let image = image {
                                self.quizImageView.image = image
                            }
                            else {
                                self.quizImageView.isHidden = true
                            }
                        }
                    }
                    
                    self.addCustomView(quiz: quizzes[x])
                }
                else {
                    self.errorLabel.isHidden = false
                }
            }
        }
    }
    
    func addCustomView(quiz: Quiz) {
        
        customView?.removeFromSuperview()
        customView = QuestionView(frame: CGRect(origin: CGPoint(x: 57, y: 400),
                                                size: CGSize(width: 300, height: 350)), quest: quiz.questions[0])
        viewContainer.addSubview(customView!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabel.isHidden = true
    }

}
*/
