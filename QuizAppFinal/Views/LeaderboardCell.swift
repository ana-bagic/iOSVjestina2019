//
//  TableViewCell.swift
//  QuizAppFinal
//
//  Created by five on 22/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.frame.size.width = UIScreen.main.bounds.size.width
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        username.text = ""
        time.text = ""
    }

    func setup(withScore score: LeaderboardCellModel) {
        username.text = score.username
        time.text = String(score.time)
    }

}
