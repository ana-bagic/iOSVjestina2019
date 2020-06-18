//
//  QuizzesViewController.swift
//  QuizAppFinal
//
//  Created by five on 09/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class QuizzesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    //var tableFooterView: ReviewsTableViewFooterView!
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    var viewModel: QuizzesViewModel!
    var numberOfQuizzes = 1
    
    convenience init(viewModel: QuizzesViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupTableView()
        setupKeyboard()
        
        //print(UserDefaults.standard.)
    }
    
    func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(QuizzesViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl

        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        //tableFooterView = ReviewsTableViewFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 200))
        // ReviewsTableViewFooterView objektu za delegata postavljamo ovaj viewController. Dolje ovaj viewController implementira protokol TableViewFooterViewDelegate
        //tableFooterView.delegate = self
        //tableView.tableFooterView = tableFooterView
    }
    
    func bindViewModel() {
        viewModel.fetchQuiz {
            self.numberOfQuizzes = self.viewModel.numberOfQuizzes()
            self.refresh()
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
    
    func countCategoryQuizzes(category: Category) -> Int {
        var x = 0
        
        for i in 0...numberOfQuizzes - 1 {
            if viewModel.quiz(atIndex: i)?.category == category {
                x += 1
            }
        }
        
        return x
    }
}

extension QuizzesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = QuizTableSectionHeader()
        
        switch section {
        case 0:
            view.titleLabel.text = Category.SPORTS.rawValue
            view.backgroundColor = Category.SPORTS.color
        default:
            view.titleLabel.text = Category.SCIENCE.rawValue
            view.backgroundColor = Category.SCIENCE.color
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            if let viewModel = viewModel.viewModel(atIndex: indexPath.row) {
                let singleQuizViewController = SingleQuizViewController(viewModel: viewModel)
                navigationController?.pushViewController(singleQuizViewController, animated: true)
            }
        default:
            if let viewModel = viewModel.viewModel(atIndex: countCategoryQuizzes(category: Category.SPORTS) + indexPath.row) {
                let singleQuizViewController = SingleQuizViewController(viewModel: viewModel)
                navigationController?.pushViewController(singleQuizViewController, animated: true)
            }
        }
    }
}

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

/*
// Primjer delegation protokola na nasem custom UIView-u ReviewsTableViewFooterView
extension ReviewsViewController: TableViewFooterViewDelegate {
    // Kada se dogodi stvaranje novog review-a u ReviewsTableViewFooterView, on ce to dojaviti svom delegatu (ovom viewControlleru) koji ce se onda dalje pobrinuti za stvaranje review-a
    func reviewCreated(withText title: String, date: String, summary: String) {
        // stvaranje review-a se naravno radi u viewModelu
        viewModel.createReview(withText: title, date: date, summary: summary)
        // Ovdje, nakon sto smo stvorili novi review, koji ce u konacnici dodati novi review u dataSoruce, mozemo pozvati tableView.reloadData() i tableView ce se osvjeziti novim podacima
        // ali u ovom trenutku, nakon dodavanja review-a u dataSource, mozemo i 'rucno' dodati jos jedan redak u tablicu (buduci da dataSource u ovom trenutku i ima jedan objekt vise nego sto tableView ima redaka)
        // Metoda insertRows prima i tip animacije dodavanja redaka, te na ovaj nacin recimo efektnije mozemo osvjeziti tablicu nakon dodavanja jednog retka
        tableView.insertRows(at: [IndexPath(row: viewModel.numberOfReviews()-1, section: 0)], with: UITableView.RowAnimation.automatic)
    }
}
*/
