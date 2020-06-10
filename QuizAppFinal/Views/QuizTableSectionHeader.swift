//
//  QuizTableSectionHeader.swift
//  QuizAppFinal
//
//  Created by five on 09/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class QuizTableSectionHeader: UIView {

    var titleLabel: UILabel!
    
    convenience init(frame: CGRect, quiz: Quiz) {
        self.init(frame: frame)
        
        backgroundColor = quiz.category.color
        if quiz.category == Category.SPORTS {
            titleLabel.text = "Sports"
        }
        else {
            titleLabel.text = "Science"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel)
        //titleLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 16.0)
        //titleLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
