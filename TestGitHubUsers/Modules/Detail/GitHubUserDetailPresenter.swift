//
//  GitHubUserDetailPresenter.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation

//MARK: - Presenter protocol
protocol GitHubUserDetailPresenterProtocol {
    func onViewDidLoad()
}


//MARK: - Main Presenter
final class GitHubUserDetailPresenter: GitHubUserDetailPresenterProtocol {
    
    //MARK: Private
    private var view: GitHubUserDetailViewControllerProtocol?
    private var apiClient: DetailGitHubUserAPIClientProtocol?
    
    //MARK: Initialization
    init(view: GitHubUserDetailViewControllerProtocol!, login: String!) {
        let url = URL(string: URLs.gitHubUserURL + login)
        self.apiClient = DetailGitHubUserAPIClient(url: url)
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        setupUser { user in
            let uiModel = DetailGitHubUsersListFormatter.format(user)
            self.view?.show(uiModel: uiModel)
        }
    }
}


//MARK: - Main methods
private extension GitHubUserDetailPresenter {
    
    //MARK: Private
    func setupUser(completion: @escaping ((DetailGitHubUserDB) -> ())) {
        Task {
            do {
                let user = try await apiClient?.getUser()
                DispatchQueue.main.async {
                    completion(user!)
                }
            } catch APIError.ACRequestError.invalidDataError {
                
            } catch APIError.ACRequestError.invalidURLError {
                
            } catch APIError.ACRequestError.sessionError {
                
            } catch {
                
            }
        }
    }
}
