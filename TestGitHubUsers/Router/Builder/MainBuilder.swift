//
//  MainBuilder.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation
import UIKit

//MARK: - Main Bulder protocol
protocol Builder {
    init(coordinator: MainCoordinator!)
    func showList(delegate: GitHubUsersListPresenterCoordinatorDelegate) -> UIViewController
    func goToDetail(login: String) -> UIViewController
}


//MARK: - Main Bulder
final class MainBuilder {
    
    //MARK: Weak
    weak var coordinator: MainCoordinator!
    
    
    //MARK: Initialization
    init(coordinator: MainCoordinator!) {
        self.coordinator = coordinator
    }
}


//MARK: - Builder protocol extension
extension MainBuilder: Builder {
    
    //MARK: Internal
    internal func showList(delegate: GitHubUsersListPresenterCoordinatorDelegate) -> UIViewController {
        let rootVC = GitHubUsersListTableViewController(nibName: "GitHubUsersListTableViewController", bundle: nil)
        rootVC.presenter = GitHubUsersListPresenter(view: rootVC, delegate: delegate)
        return rootVC
    }
    
    internal func goToDetail(login: String) -> UIViewController {
        let rootVC = GitHubUserDetailViewController()
        let presenter = GitHubUserDetailPresenter(view: rootVC, login: login)
        rootVC.presenter = presenter
        return rootVC
    }
}

