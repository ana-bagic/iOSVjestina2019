//
//  QuestionView.swift
//  QuizAppFinal
//
//  Created by five on 06/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class QuestionView: UIView, UIScrollViewDelegate {
    
    var question: UILabel!
    var answer1: UIButton!
    var answer2: UIButton!
    var answer3: UIButton!
    var answer4: UIButton!
    
    convenience init(frame: CGRect, quest: Question) {
        self.init(frame: frame)
        
        question?.text = quest.question
        let correct = quest.correct_answer
        
        answer1?.setTitle(quest.a, for: .normal)
        if (correct == 0) {
            answer1?.tag = 1
        }
        else {
            answer1?.tag = 0
        }
        
        answer2?.setTitle(quest.b, for: .normal)
        if (correct == 1) {
            answer2?.tag = 1
        }
        else {
            answer2?.tag = 0
        }
        
        answer3?.setTitle(quest.c, for: .normal)
        if (correct == 2) {
            answer3?.tag = 1
        }
        else {
            answer3?.tag = 0
        }
        
        answer4?.setTitle(quest.d, for: .normal)
        if (correct == 3) {
            answer4?.tag = 1
        }
        else {
            answer4?.tag = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        question = UILabel()
        answer1 = UIButton()
        answer2 = UIButton()
        answer3 = UIButton()
        answer4 = UIButton()
        
        let screenSize = UIScreen.main.bounds
        let startX = screenSize.width * 0.2
        let labelWidth = screenSize.width * 0.6
        
        question = UILabel(frame: CGRect(origin: CGPoint(x: startX, y: 10),
                            size: CGSize(width: labelWidth, height: 80)))
        question?.numberOfLines = 0
        
        answer1 = UIButton(frame: CGRect(origin: CGPoint(x: startX, y: 100),
                            size: CGSize(width: 250, height: 35)))
        answer1?.setTitleColor(UIColor.black, for: .normal)
        answer1?.contentHorizontalAlignment = .left
    
        answer2 = UIButton(frame: CGRect(origin: CGPoint(x: startX, y: 140),
                            size: CGSize(width: 250, height: 35)))
        answer2?.setTitleColor(UIColor.black, for: .normal)
        answer2?.contentHorizontalAlignment = .left
        
        answer3 = UIButton(frame: CGRect(origin: CGPoint(x: startX, y: 180),
                            size: CGSize(width: 250, height: 35)))
        answer3?.setTitleColor(UIColor.black, for: .normal)
        answer3?.contentHorizontalAlignment = .left
        
        answer4 = UIButton(frame: CGRect(origin: CGPoint(x: startX, y: 220),
                            size: CGSize(width: 250, height: 35)))
        answer4?.setTitleColor(UIColor.black, for: .normal)
        answer4?.contentHorizontalAlignment = .left
        
        self.addSubview(question)
        self.addSubview(answer1)
        self.addSubview(answer2)
        self.addSubview(answer3)
        self.addSubview(answer4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
