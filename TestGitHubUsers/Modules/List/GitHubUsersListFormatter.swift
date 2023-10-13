//
//  GitHubUsersListFormatter.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-08.
//

import Foundation

//MARK: - Main Formatter
final class GitHubUsersListFormatter {
    
    //MARK: Static
    static func format(_ dbModels: [GitHubUserDB]) -> [GitHubUserCellUIModel] {
        return dbModels.map { GitHubUserCellUIModel(
            login: $0.login,
            avatarURL: URL(string: $0.avatar_url)!,
            url: $0.url,
            id: $0.id)
        }
    }
}
