//
//  GitHubUserDetailFormatter.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-08.
//

import Foundation

//MARK: - Main Formatter
final class DetailGitHubUsersListFormatter {
    
    //MARK: Static
    static func format(_ dbModel: DetailGitHubUserDB) -> DetailGitHubUserCellUIModel {
        return DetailGitHubUserCellUIModel(login: dbModel.login,
                                           url: dbModel.url,
                                           avatarURL: URL(string: dbModel.avatar_url),
                                           followers: String(dbModel.followers),
                                           following: String(dbModel.following),
                                           gists: String(dbModel.public_gists)
        )
    }
}

