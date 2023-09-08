//
//  MainCoordinator.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation
import UIKit

//MARK: - Base Coordinator protocol
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}


//MARK: - Main Coordinator protocol
protocol MainCoordinatorProtocol: Coordinator {
    var builder: MainBuilder? { get set }
    func goToDetails(login: String)
}


//MARK: - Main Coordinator
final class MainCoordinator: Coordinator {
    var builder: MainBuilder?
    var navigationController: UINavigationController
    
    
    //MARK: Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.builder = MainBuilder(coordinator: self)
    }
}


//MARK: - Main Coordinator protocol extension
extension MainCoordinator: MainCoordinatorProtocol {
    
    //MARK: Internal
    internal func start() {
        let rootVC = builder?.showList(delegate: self)
        navigationController.pushViewController(rootVC!, animated: true)
    }
    
    internal func goToDetails(login: String) {
        let registerVC = builder?.goToDetail(login: login)
        navigationController.pushViewController(registerVC!, animated: true)
    }
}


//MARK: - GitHub Users List delegate protocol extension
extension MainCoordinator: GitHubUsersListPresenterCoordinatorDelegate {
    
    //MARK: Internal
    func presenter(_ presenter: GitHubUsersListPresenterProtocol, onGoToDetailed withLogin: String?) {
        goToDetails(login: withLogin!)
    }
}
