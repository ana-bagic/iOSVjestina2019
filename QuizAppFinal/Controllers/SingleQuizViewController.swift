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
    
    @IBAction func startQuiz(_ sender: Any) {
        scrollView?.isHidden = false
    }
    
    func setupSlideScrollView() {
        
        var i = 0
        if let qs = viewModel.quiz?.questions {
            
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(qs.count), height: scrollView.frame.height)
            
            for question in qs {
                let customView = QuestionView(frame: CGRect(origin: CGPoint(x: view.frame.width * CGFloat(i), y: 0), size: CGSize(width: view.frame.width, height: scrollView.frame.height)), quest: question)
                i += 1
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
        
        print(scrollView.frame.height)
    }

    func bindViewModel() {
        titleLabel.text = viewModel.title
        imageView.kf.setImage(with: viewModel.imageUrl)
    }
    
}
