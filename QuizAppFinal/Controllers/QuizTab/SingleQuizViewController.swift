//
//  SingleQuizViewController.swift
//  QuizAppFinal
//
//  Created by five on 09/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import Kingfisher

class SingleQuizViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel: SingleQuizViewModel!
    var currentPage = 0
    var numberOfCorrect = 0
    var startTime = Date()
    var endTime = Date()
    
    @IBAction func startQuiz(_ sender: Any) {
        scrollView?.isHidden = false
        startTime = Date()
    }
    
    @IBAction func leaderboard(_ sender: Any) {
        let leaderboardViewController = LeaderboardViewController(viewModel: LeaderboardViewModel())
        navigationController?.pushViewController(leaderboardViewController, animated: true)
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        if (sender.tag == 1) {
            sender.backgroundColor = .green
            numberOfCorrect += 1
        }
        else {
            sender.backgroundColor = .red
        }
        
        if (currentPage + 1 < viewModel.quiz?.questions.count ?? 0) {
            let screenSize = UIScreen.main.bounds
            
            var frame: CGRect = self.scrollView.frame
            frame.origin.x = screenSize.width * CGFloat(currentPage + 1)
            frame.origin.y = 0
            self.scrollView.scrollRectToVisible(frame, animated: true)
            
            currentPage += 1
        }
        else {
            endTime = Date()
            sendToServer()
        }
    }
    
    func sendToServer() {
        let finishedQuizService = FinishedQuizService()
        
        let time = endTime.timeIntervalSince(startTime)
        let userDefaults = UserDefaults.standard
        if let quiz_id = viewModel.quiz?.id,
            let user_id = userDefaults.string(forKey: "user_id") {
            finishedQuizService.send(quiz: quiz_id, user: user_id, time: time, correct: numberOfCorrect) { (json) in
                
                DispatchQueue.main.async {
                    if let jsonDict = json as? [String: Any] {
                        print(jsonDict)
                        
                        if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                        }
                    }
                    else {
                        self.errorLabel.isHidden = false
                    }
                }
            }
        }
        else {
            self.errorLabel.isHidden = false
        }
    }
    
    func setupSlideScrollView() {
        let screenSize = UIScreen.main.bounds
        
        scrollView.frame = CGRect(x: 0, y: screenSize.height/2, width: screenSize.width, height: screenSize.height/2)
    
        var i = 0
        if let qs = viewModel.quiz?.questions {
            
            scrollView.contentSize = CGSize(width: screenSize.width * CGFloat(qs.count), height: scrollView.frame.height)
            
            for question in qs {
                let customView = QuestionView(frame: CGRect(origin: CGPoint(x: screenSize.width * CGFloat(i), y: 0), size: CGSize(width: screenSize.width, height: scrollView.frame.height)), quest: question)
                i += 1
                
                customView.answer1?.addTarget(self, action: #selector(buttonClicked(_: )), for: UIControl.Event.touchUpInside)
                customView.answer2?.addTarget(self, action: #selector(buttonClicked(_: )), for: UIControl.Event.touchUpInside)
                customView.answer3?.addTarget(self, action: #selector(buttonClicked(_: )), for: UIControl.Event.touchUpInside)
                customView.answer4?.addTarget(self, action: #selector(buttonClicked(_: )), for: UIControl.Event.touchUpInside)
                
                scrollView.addSubview(customView)
            }
        }
    }
    
    convenience init(viewModel: SingleQuizViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        self.scrollView?.isHidden = true
        self.errorLabel.isHidden = true
        self.startButton.layer.cornerRadius = 4
        self.leaderboardButton.layer.cornerRadius = 4
        self.startButton.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        self.leaderboardButton.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        
        setupSlideScrollView()
    }

    func bindViewModel() {
        titleLabel.text = viewModel.title
        imageView.kf.setImage(with: viewModel.imageUrl)
    }
    
}
