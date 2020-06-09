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
    var customView: UIView?
    
    var viewModel: SingleQuizViewModel!
    
    @IBAction func startQuiz(_ sender: Any) {
        customView?.isHidden = false
    }
    
    convenience init(viewModel: SingleQuizViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        self.addCustomView(quiz: viewModel.quiz!)
        customView?.isHidden = true
    }

    func bindViewModel() {
        titleLabel.text = viewModel.title
        imageView.kf.setImage(with: viewModel.imageUrl)
    }
    
    func addCustomView(quiz: Quiz) {
        customView?.removeFromSuperview()
        customView = QuestionView(frame: CGRect(origin: CGPoint(x: 50, y: 350),
                                size: CGSize(width: 350, height: 350)), quiz: quiz)
        viewContainer.addSubview(customView!)
    }
}
