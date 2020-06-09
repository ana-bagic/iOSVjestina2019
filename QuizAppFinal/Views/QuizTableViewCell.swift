//
//  QuizTableViewCell.swift
//  QuizAppFinal
//
//  Created by five on 09/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import Kingfisher

class QuizTableViewCell: UITableViewCell {

    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var quizDescription: UILabel!
    @IBOutlet weak var level1: UIImageView!
    @IBOutlet weak var level2: UIImageView!
    @IBOutlet weak var level3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quizDescription.numberOfLines = 0
        level1.isHidden = true
        level2.isHidden = true
        level3.isHidden = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        quizImage?.image = nil
        quizTitle.text = ""
        quizDescription.text = ""
        level1.isHidden = true
        level2.isHidden = true
        level3.isHidden = true
    }
    
    func setup(withQuiz quiz: QuizCellModel) {
        quizTitle.text = quiz.title
        quizDescription.text = quiz.description
        level1.isHidden = false
        
        switch quiz.level {
            case 2:
                level2.isHidden = false
            case 3:
                level2.isHidden = false
                level3.isHidden = false
            default:
                break
        }
        
        if let url = quiz.imageUrl {
            quizImage.kf.setImage(with: url)
        }
    }
    
}
