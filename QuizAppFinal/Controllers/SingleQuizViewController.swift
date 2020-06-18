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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
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
    
    @objc func buttonClicked(_ sender: UIButton) {
        if (sender.tag == 1) {
            sender.backgroundColor = .green
            numberOfCorrect += 1
        }
        else {
            sender.backgroundColor = .red
        }
        
        if (currentPage + 1 < viewModel.quiz?.questions.count ?? 0) {
            var frame: CGRect = self.scrollView.frame
            frame.origin.x = frame.size.width * CGFloat(currentPage + 1)
            frame.origin.y = 0
            self.scrollView.scrollRectToVisible(frame, animated: true)
            
            currentPage += 1
        }
        else {
            endTime = Date()
            sendToServer()
            //print(endTime.timeIntervalSince(startTime))
        }
    }
    
    func sendToServer() {
        let finishedQuizService = FinishedQuizService()
        
        let time = endTime.timeIntervalSince(startTime)
        let userDefaults = UserDefaults.standard
        if let quiz_id = viewModel.quiz?.id, let user_id = userDefaults.string(forKey: "user_id") {
            finishedQuizService.send(quiz: quiz_id, user: user_id, time: time, correct: numberOfCorrect) { (json) in
                
                DispatchQueue.main.async {
                    if let jsonDict = json as? [String: Any] {
                        print(jsonDict)
                    }
                }
            }
        }
    }
    
    func setupSlideScrollView() {
        var i = 0
        if let qs = viewModel.quiz?.questions {
            
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(qs.count), height: scrollView.frame.height)
            
            for question in qs {
                let customView = QuestionView(frame: CGRect(origin: CGPoint(x: view.frame.width * CGFloat(i), y: 0), size: CGSize(width: view.frame.width, height: scrollView.frame.height)), quest: question)
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
        scrollView?.isHidden = true
        setupSlideScrollView()
    }

    func bindViewModel() {
        titleLabel.text = viewModel.title
        imageView.kf.setImage(with: viewModel.imageUrl)
    }
    
}
