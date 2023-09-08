//
//  GitHubUsersListPresenter.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation

//MARK: - Presenter protocol
protocol GitHubUsersListPresenterProtocol {
    func onViewDidLoad(completion: @escaping (([GitHubUserCellUIModel]) -> ()))
    func onDidSelectRow(with login: String)
    func onRefresh()
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
    func onViewDidLoad(completion: @escaping (([GitHubUserCellUIModel]) -> ())) {
        view?.setupMainUI()
        setupUsers { dbModels in
            completion(GitHubUsersListFormatter.format(dbModels))
            self.view?.refreshTableView()
        }
    }

    func onRefresh() {
        view?.refreshTableView()
        view?.endRefreshingAnimation()
    }
    
    func onDidSelectRow(with login: String) {
        delegate?.presenter(self, onGoToDetailed: login)
    }
}

//MARK: - Main methods
private extension GitHubUsersListPresenter {
    
    //MARK: Private
    func setupUsers(completion: @escaping (([GitHubUserDB]) -> ())) {
        Task {
            do {
                let dbModels = try await apiClient?.getUsers()
                print(dbModels?.count ?? 0)
                DispatchQueue.main.async {
                    completion(dbModels ?? [])
                }
            } catch APIError.ACRequestError.invalidDataError {
                showError(with: "Invalid Data Error.")
            } catch APIError.ACRequestError.invalidURLError {
                showError(with: "Invalid URL Error.")
            } catch APIError.ACRequestError.sessionError {
                showError(with: "Session Error.")
            } catch {
                showError(with: "Unexpected Error. Check your Wi-Fi connection.")
            }
        }
    }
    
    func showError(with message: String) {
        DispatchQueue.main.async {
            self.view?.presentErrorAlertVC(message: message)
        }
    }
}
