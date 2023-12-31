//
//  GitHubUsersListPresenter.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation

//MARK: - Constants
private extension GitHubUsersListPresenter {
    
    //MARK: Private
    enum Constants {
        enum ErrorMessage {
            
            //MARK: Static
            static let basicMessage = "Error fetching GitHub Users Data:"
        }
    }
}


//MARK: - Presenter protocol
protocol GitHubUsersListPresenterProtocol {
    func onViewDidLoad()
    func onRefresh()
    func onDidSelectRow(with login: String)
}


//MARK: - Coordinator delegate protocol
protocol GitHubUsersListPresenterCoordinatorDelegate {
    func presenter(_ presenter: GitHubUsersListPresenterProtocol, onGoToDetailed withLogin: String?)
}


//MARK: - Main Presenter
final class GitHubUsersListPresenter: GitHubUsersListPresenterProtocol {
    
    //MARK: Private
    private var view: GitHubUsersListTableViewControllerProtocol?
    private var apiClient: AllGitHubUsersAPIClientProtocol?
    private var delegate: GitHubUsersListPresenterCoordinatorDelegate?
    
    
    //MARK: Initialization
    init(view: GitHubUsersListTableViewControllerProtocol!,
         delegate: GitHubUsersListPresenterCoordinatorDelegate!) {
        self.view = view
        self.delegate = delegate
        self.apiClient = AllGitHubUsersAPIClient(url: URL(string: URLs.gitHubUsersURL))
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        view?.setupMainUI()
        fetchUsers { [weak self] dbModels in
            self?.reloadUsers(with: dbModels)
        }
    }

    func onRefresh() {
        let stringURL = URLs.gitHubUsersBaseURL + Int.randomUsersSinceIndex()
        guard let url = URL(string: stringURL) else { return }
        view?.endRefreshingAnimation()
        apiClient?.update(with: url)
        fetchUsers { [weak self] dbModels in
            self?.reloadUsers(with: dbModels)
        }
    }
    
    func onDidSelectRow(with login: String) {
        delegate?.presenter(self, onGoToDetailed: login)
    }
}


//MARK: - Main methods
private extension GitHubUsersListPresenter {
    
    //MARK: Private
    func fetchUsers(completion: @escaping (([GitHubUserDB]) -> ())) {
        Task {
            do {
                let dbModels = try await apiClient?.getUsers()
                print(dbModels?.count ?? 0)
                DispatchQueue.main.async {
                    completion(dbModels ?? [])
                }
            } catch {
                print(Constants.ErrorMessage.basicMessage)
                print(error)
            }
        }
    }
    
    func showError(with message: String) {
        DispatchQueue.main.async {
            self.view?.presentErrorAlertVC(message: message)
        }
    }
    
    func reloadUsers(with dbModels: [GitHubUserDB]) {
        view?.updateRows(with: GitHubUsersListFormatter.format(dbModels))
        view?.refreshTableView()
    }
}
