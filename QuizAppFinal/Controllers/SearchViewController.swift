//
//  SearchViewController.swift
//  QuizAppFinal
//
//  Created by five on 18/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import PureLayout

class SearchViewController: UIViewController {
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    var viewModel: QuizzesViewModel!
    var searchResult = [QuizCellModel]()
    var numberOfQuizzes = 0
    
    @IBAction func search(_ sender: Any) {
        searchResult.removeAll()
        
        if let searchBy = searchText.text?.lowercased() {
            
            for n in 0...numberOfQuizzes - 1 {
                if let quiz = viewModel.quiz(atIndex: n) {
                    if (quiz.description.lowercased().contains(searchBy) || quiz.title.lowercased().contains(searchBy)) {
                        searchResult.append(quiz)
                    }
                }
            }
            
            setupTableView()
            self.refresh()
            tableView.isHidden = false
        }
    }
    
    convenience init(viewModel: QuizzesViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.autoSetDimension(.width, toSize: UIScreen.main.bounds.width * 0.6)
        tableView.isHidden = true
        
        bindViewModel()
        setupKeyboard()
    }
        
    func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.frame = CGRect(x: 0, y: 135, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 135)
            
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SearchViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl

        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
        
    func bindViewModel() {
        viewModel.fetchQuiz {
            self.numberOfQuizzes = self.viewModel.numberOfQuizzes()
        }
    }
        
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
        
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = getKeyboardHeight(notification: notification) {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
        
    @objc func keyboardWillHide(notification: NSNotification){
        if let keyboardHeight = getKeyboardHeight(notification: notification) {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
        
    func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            return keyboardHeight
        }
        return nil
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140.0
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
        if let viewModel = viewModel.viewModel(atIndex: indexPath.row) {
            let singleQuizViewController = SingleQuizViewController(viewModel: viewModel)
            navigationController?.pushViewController(singleQuizViewController, animated: true)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizTableViewCell

        if searchResult.count != 0 {
            if let quiz = viewModel.viewModelForId(id: searchResult[indexPath.row].id) {
                    cell.setup(withQuiz: quiz)
            }
        }
        
        return cell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
}
