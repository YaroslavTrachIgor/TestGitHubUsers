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
    func updateRows(with rows: [GitHubUserCellUIModel])
    func presentErrorAlertVC(message: String)
}


//MARK: - Main ViewController
final class GitHubUsersListTableViewController: UITableViewController {
      
    //MARK: Public
    var presenter: GitHubUsersListPresenterProtocol?
    
    //MARK: Private
    private var rows = [GitHubUserCellUIModel]()
    private var filteredRows = [GitHubUserCellUIModel]()
    private var currentRows: [GitHubUserCellUIModel]! {
        if isSearchBarActive {
            return filteredRows
        } else {
            return rows
        }
    }
    private let refreshUsersControl = UIRefreshControl()
    private var searchController: UISearchController!
    private var isSearchBarActive: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad()
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
        return currentRows.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = currentRows[indexPath.row]
        let login = row.login
        presenter?.onDidSelectRow(with: login!)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = currentRows[indexPath.row]
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
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setupSearchController()
        setupRefreshUsersControl()
    }
    
    func updateRows(with rows: [GitHubUserCellUIModel]) {
        self.rows = rows
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
        tableView.separatorColor = .clear
        tableView.rowHeight = 155
    }
    
    func setupRefreshUsersControl() {
        refreshUsersControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshUsersControl
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Users"
        searchController.searchBar.tintColor = .systemPink
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}


//MARK: - Search results updating protocol extension
extension GitHubUsersListTableViewController: UISearchResultsUpdating {
    
    //MARK: Internal
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased() ?? ""
        filteredRows = rows.filter { $0.login.lowercased().contains(searchText) }
        tableView.reloadData()
    }
}
