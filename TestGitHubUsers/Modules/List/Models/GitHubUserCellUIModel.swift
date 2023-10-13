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
    let url: String!
    let id: Int!
}


//MARK: - Cell UIModel protocol extension
extension GitHubUserCellUIModel: BaseCellUIModel {
    
    //MARK: Internal
    func setup(cell: GitHubUsersListTableViewCell) {
        cell.idLabel.text = "ID: \(id ?? 0)"
        cell.titleLabal.text = login
        cell.subtitleLabel.text = url
        cell.iconImageView.downloadImage(with: avatarURL)
        cell.followingLabel.text = "\(Int.random(in: 1...100))"
        cell.followersLabel.text = "\(Int.random(in: 1...100))"
        cell.gistsLabel.text = "\(Int.random(in: 1...25))"
    }
}
