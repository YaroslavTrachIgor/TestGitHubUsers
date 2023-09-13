//
//  GitHubUsersListTableViewController.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation
import UIKit

//MARK: - Constants
private extension GitHubUsersListTableViewController {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum NavigationItem {
                
                //MARK: Static
                static let title = "GitHub Users"
            }
            enum AlertController {
                enum ErrorAlert {
                    
                    //MARK: Static
                    static let title = "Error"
                    static let okAction = "OK"
                }
            }
            enum RefreshControl {
                
                //MARK: Static
                static let title = "Pull to refresh"
            }
        }
    }
}


//MARK: - ViewController protocol
protocol GitHubUsersListTableViewControllerProtocol {
    func setupMainUI()
    func refreshTableView()
    func endRefreshingAnimation()
    func presentErrorAlertVC(message: String)
}


//MARK: - Main ViewController
final class GitHubUsersListTableViewController: UITableViewController {
      
    //MARK: Public
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
    
    //MARK: @objc
    @objc func refresh() {
        presenter?.onRefresh()
    }
    
    //MARK: TableView DataSource protocol
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


//MARK: - ViewController protocol extension
extension GitHubUsersListTableViewController: GitHubUsersListTableViewControllerProtocol {
    
    //MARK: Internal
    func setupMainUI() {
        title = Constants.UI.NavigationItem.title
        view.backgroundColor = .systemGroupedBackground
        setupTableView()
        setupRefreshUsersControl()
    }
    
    func endRefreshingAnimation() {
        refreshUsersControl.endRefreshing()
    }
    
    func presentErrorAlertVC(message: String) {
        let title = Constants.UI.AlertController.ErrorAlert.title
        let okActiontitle = Constants.UI.AlertController.ErrorAlert.okAction
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActiontitle, style: .cancel)
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
    
    func refreshTableView() {
        tableView.reloadData()
    }
}


//MARK: - Main methods
private extension GitHubUsersListTableViewController {
    
    //MARK: Private
    func setupTableView() {
        let cellKey = String(describing: GitHubUsersListTableViewCell.self)
        let cellNib = UINib(nibName: cellKey, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellKey)
        tableView.rowHeight = 85
    }
    
    func setupRefreshUsersControl() {
        let title = Constants.UI.RefreshControl.title
        refreshUsersControl.attributedTitle = NSAttributedString(string: title)
        refreshUsersControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshUsersControl
    }
}
