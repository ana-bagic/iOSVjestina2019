//
//  LeaderboardViewController.swift
//  QuizAppFinal
//
//  Created by five on 18/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

/*
class LeaderboardViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    let cellReuseIdentifier = "cellReuseIdentifier"
        
    var viewModel: LeaderboardViewModel!
    //var numberOfQuizzes = 1
        
    convenience init(viewModel: LeaderboardViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        //setupTableView()
    }
    
    /*
    func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(QuizzesViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    */
    
    func bindViewModel() {
        let url = "https://iosquiz.herokuapp.com/api/score?quiz_id=4"
        
        viewModel.getData(urlString: url) {
            //self.numberOfQuizzes = self.viewModel.numberOfQuizzes()
            //self.refresh()
        }
    }
        
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
      
    /*
    func countCategoryQuizzes(category: Category) -> Int {
        var x = 0
        
        for i in 0...numberOfQuizzes - 1 {
            if viewModel.quiz(atIndex: i)?.category == category {
                x += 1
            }
        }
        
        return x
    }
    */
}

extension LeaderboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = QuizTableSectionHeader()
            
        view.titleLabel.text = "Leaderboard"
        view.backgroundColor = .blue
            
        return view
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}

/*
extension QuizzesViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizTableViewCell
            
        if indexPath.section == 0 {
            if let quiz = viewModel.quiz(atIndex: indexPath.row) {
                    cell.setup(withQuiz: quiz)
            }
        }
        else {
            if let quiz = viewModel.quiz(atIndex: countCategoryQuizzes(category: Category.SPORTS) + indexPath.row) {
                cell.setup(withQuiz: quiz)
            }
        }
        return cell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return Category.numberOfCat
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return countCategoryQuizzes(category: Category.SPORTS)
        }
        else {
            return countCategoryQuizzes(category: Category.SCIENCE)
        }
    }
}
*/
 */
