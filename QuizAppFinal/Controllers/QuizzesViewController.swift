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
    
    convenience init(viewModel: QuizzesViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        //setupKeyboard()
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
}

extension QuizzesViewController: UITableViewDelegate {
    // visinu celije za oderedeni indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    // view za header jedne sekcije
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = QuizTableSectionHeader()
        return view
    }
    
    // visina view-a headera jedne sekcije
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let viewModel = viewModel.viewModel(atIndex: indexPath.row) {
            let singleQuizViewController = SingleQuizViewController(viewModel: viewModel)
            navigationController?.pushViewController(singleQuizViewController, animated: true)
        }
    }
}

extension QuizzesViewController: UITableViewDataSource {
    
    // UITableViewCell koji ce prikazati za odredeni indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizTableViewCell
        
        if let quiz = viewModel.quiz(atIndex: indexPath.row) {
            cell.setup(withQuiz: quiz)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // broj redaka koje treba prikazati u tablici
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfQuizzes()
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
