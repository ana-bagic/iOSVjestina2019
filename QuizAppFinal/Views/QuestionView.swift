//
//  QuestionView.swift
//  QuizAppFinal
//
//  Created by five on 06/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class QuestionView: UIView, UIScrollViewDelegate {
    
    var question: UILabel?
    var answer1: UIButton?
    var answer2: UIButton?
    var answer3: UIButton?
    var answer4: UIButton?
    
    func removeButtonColor () {
        answer1?.backgroundColor = .white
        answer2?.backgroundColor = .white
        answer3?.backgroundColor = .white
        answer4?.backgroundColor = .white
    }
    
    @objc func buttonClicked(_ sender: AnyObject?) {
        removeButtonColor()
        if (sender === answer1) {
            if (answer1?.tag == 1) {
                answer1?.backgroundColor = .green
            }
            else {
                answer1?.backgroundColor = .red
            }
        }
        else if (sender === answer2) {
            if (answer2?.tag == 1) {
                answer2?.backgroundColor = .green
            }
            else {
                answer2?.backgroundColor = .red
            }
        }
        else if (sender === answer3) {
            if (answer3?.tag == 1) {
                answer3?.backgroundColor = .green
            }
            else {
                answer3?.backgroundColor = .red
            }
        }
        else if (sender === answer4) {
            if (answer4?.tag == 1) {
                answer4?.backgroundColor = .green
            }
            else {
                answer4?.backgroundColor = .red
            }
        }
    }
    
    convenience init(frame: CGRect, quest: Question) {
        self.init(frame: frame)
        
        question?.text = quest.question
        let correct = quest.correct_answer
        
        answer1?.setTitle(quest.answers[0], for: .normal)
        if (correct == 0) {
            answer1?.tag = 1
        }
        else {
            answer1?.tag = 0
        }
        answer1?.addTarget(self, action: #selector(buttonClicked(_: )), for: UIControl.Event.touchUpInside)
        
        answer2?.setTitle(quest.answers[1], for: .normal)
        if (correct == 1) {
            answer2?.tag = 1
        }
        else {
            answer2?.tag = 0
        }
        answer2?.addTarget(self, action: #selector(buttonClicked(_:)), for: UIControl.Event.touchUpInside)
        
        answer3?.setTitle(quest.answers[2], for: .normal)
        if (correct == 2) {
            answer3?.tag = 1
        }
        else {
            answer3?.tag = 0
        }
        answer3?.addTarget(self, action: #selector(buttonClicked(_:)), for: UIControl.Event.touchUpInside)
        
        answer4?.setTitle(quest.answers[3], for: .normal)
        if (correct == 3) {
            answer4?.tag = 1
        }
        else {
            answer4?.tag = 0
        }
        answer4?.addTarget(self, action: #selector(buttonClicked(_:)), for: UIControl.Event.touchUpInside)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        question = UILabel(frame: CGRect(origin: CGPoint(x: 50, y: 10),
                            size: CGSize(width: 250, height: 80)))
        question?.numberOfLines = 0
        
        answer1 = UIButton(frame: CGRect(origin: CGPoint(x: 50, y: 100),
                            size: CGSize(width: 250, height: 35)))
        answer1?.setTitleColor(UIColor.black, for: .normal)
        answer1?.contentHorizontalAlignment = .left
    
        answer2 = UIButton(frame: CGRect(origin: CGPoint(x: 50, y: 140),
                            size: CGSize(width: 250, height: 35)))
        answer2?.setTitleColor(UIColor.black, for: .normal)
        answer2?.contentHorizontalAlignment = .left
        
        answer3 = UIButton(frame: CGRect(origin: CGPoint(x: 50, y: 180),
                            size: CGSize(width: 250, height: 35)))
        answer3?.setTitleColor(UIColor.black, for: .normal)
        answer3?.contentHorizontalAlignment = .left
        
        answer4 = UIButton(frame: CGRect(origin: CGPoint(x: 50, y: 220),
                            size: CGSize(width: 250, height: 35)))
        answer4?.setTitleColor(UIColor.black, for: .normal)
        answer4?.contentHorizontalAlignment = .left
        
        if let question = question {
            self.addSubview(question)
        }
        
        if let answer1 = answer1 {
            self.addSubview(answer1)
        }
        
        if let answer2 = answer2 {
            self.addSubview(answer2)
        }
        
        if let answer3 = answer3 {
            self.addSubview(answer3)
        }
        
        if let answer4 = answer4 {
            self.addSubview(answer4)
        }
        
        //self.backgroundColor = UIColor.purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
