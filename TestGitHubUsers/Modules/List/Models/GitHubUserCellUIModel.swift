//
//  GitHubUserCellUIModel.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation
import UIKit

//MARK: - Main UIModel
struct GitHubUserCellUIModel {
    let login: String!
    let avatarURL: URL!
    let id: Int!
}


//MARK: - Cell UIModel protocol extension
extension GitHubUserCellUIModel: BaseCellUIModel {
    
    //MARK: Internal
    func setup(cell: GitHubUsersListTableViewCell) {
        cell.titleLabal.text = login
        cell.subtitleLabel.text = String(id)
        cell.iconImageView.downloadImage(with: avatarURL)
    }
}
