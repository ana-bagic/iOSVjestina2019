//
//  LeaderboardViewController.swift
//  QuizAppFinal
//
//  Created by five on 18/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    let cellReuseIdentifier = "cellReuseIdentifier"
    var viewModel: LeaderboardViewModel!
        
    convenience init(viewModel: LeaderboardViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(LeaderboardViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(UINib(nibName: "LeaderboardCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func bindViewModel() {
        if let quizId = viewModel.quiz?.id {
            let url = "https://iosquiz.herokuapp.com/api/score?quiz_id=" + String(quizId)
            
            viewModel.getData(urlString: url) {
                self.refresh()
            }
        }
    }
        
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
      
}

extension LeaderboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

extension LeaderboardViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! LeaderboardCell
            
        if let score = viewModel.score(atIndex: indexPath.row) {
                cell.setup(withScore: score)
        }
        return cell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}
