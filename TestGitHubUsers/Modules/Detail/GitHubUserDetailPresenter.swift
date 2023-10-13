//
//  GitHubUserDetailPresenter.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation

//MARK: - Constants
private extension GitHubUserDetailPresenter {
    
    //MARK: Private
    enum Constants {
        enum ErrorMessage {
            
            //MARK: Static
            static let basicMessage = "Error fetching Followers GitHub Users Data:"
        }
    }
}


//MARK: - Presenter protocol
protocol GitHubUserDetailPresenterProtocol {
    func onViewDidLoad()
}


//MARK: - Main Presenter
final class GitHubUserDetailPresenter: GitHubUserDetailPresenterProtocol {
    
    //MARK: Private
    private var view: GitHubUserDetailViewControllerProtocol?
    private var apiClient: DetailGitHubUserAPIClientProtocol?
    private var followerAPIClient: AllGitHubUsersAPIClientProtocol?
    
    //MARK: Initialization
    init(view: GitHubUserDetailViewControllerProtocol!, login: String!) {
        let url = URL(string: URLs.gitHubUserURL + login)
        self.apiClient = DetailGitHubUserAPIClient(url: url)
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        Task {
            do {
                guard let user = try await setupUser() else { return }
                guard let followers = try await setupUserFollowers() else { return }
                
                ///Move to the main Thread to update UI in the ViewController.
                await MainActor.run { [weak self] in
                    let uiModel = DetailGitHubUsersListFormatter.format(user)
                    let uiModels = GitHubUsersListFormatter.format(followers)
                    self?.view?.show(uiModel: uiModel)
                    self?.view?.updateFollowers(with: uiModels)
                    self?.view?.setupMainUI()
                }
            } catch {
                print(Constants.ErrorMessage.basicMessage)
                print(error.localizedDescription)
            }
        }
    }
}


//MARK: - Main methods
private extension GitHubUserDetailPresenter {
    
    //MARK: Private
    func setupUser() async throws -> DetailGitHubUserDB? {
        let user = try await apiClient?.getUser()
        guard let user = user, let followersURL = user.followers_url else { return nil }
        /**
         In order to fill in the Followers API Cleint with the correct URL address,
         we first have to fetch all the Detailed data about a particular user and only then
         extract the followers URL from the user's DB model.
         */
        followerAPIClient = AllGitHubUsersAPIClient(url: URL(string: followersURL))
        return user
    }
    
    func setupUserFollowers() async throws -> [GitHubUserDB]? {
        return try await followerAPIClient?.getUsers()
    }
}
