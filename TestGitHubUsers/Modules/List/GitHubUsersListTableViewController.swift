//
//  GitHubUsersListTableViewController.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation
import UIKit

//MARK: - ViewController protocol
protocol GitHubUsersListTableViewControllerProtocol {
    func setupMainUI()
    func refreshTableView()
    func endRefreshingAnimation()
    func presentErrorAlertVC(message: String)
}


//MARK: - Main ViewController
final class GitHubUsersListTableViewController: UITableViewController, GitHubUsersListTableViewControllerProtocol {
        
    var presenter: GitHubUsersListPresenterProtocol?
    
    //MARK: Private
    private var rows = [GitHubUserCellUIModel]()
    private let refreshUsersControl = UIRefreshControl()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad(completion: { rows in
            self.rows = rows
        })
    }
    
    //MARK: ViewController protocol
    func setupMainUI() {
        title = "GitHub Users"
        
        view.backgroundColor = .systemGroupedBackground
        
        let cellKey = String(describing: GitHubUsersListTableViewCell.self)
        tableView.register(UINib(nibName: cellKey, bundle: nil), forCellReuseIdentifier: cellKey)
        tableView.rowHeight = 85
        
        refreshUsersControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshUsersControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshUsersControl
    }
    
    func endRefreshingAnimation() {
        refreshUsersControl.endRefreshing()
    }
    
    func presentErrorAlertVC(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
    
    func refreshTableView() {
        tableView.reloadData()
    }
    
    //MARK: @objc
    @objc func refresh() {
        presenter?.onRefresh()
    }
    
    //MARK: TableView Data Source protocol
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        let login = row.login
        presenter?.onDidSelectRow(with: login!)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withModel: row, indexPath: indexPath)
        return cell
    }
}
