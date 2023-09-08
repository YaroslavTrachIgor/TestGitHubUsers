//
//  GitHubUsersListTableViewCell.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import UIKit

//MARK: - Main TableView Cell
final class GitHubUsersListTableViewCell: UITableViewCell {

    //MARK: @IBOutlets
    @IBOutlet weak var titleLabal: UILabel! {
        didSet {
            titleLabal.textColor = .label
            titleLabal.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.textColor = .secondaryLabel
            subtitleLabel.font = UIFont.systemFont(ofSize: 15.5, weight: .regular)
        }
    }
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .secondarySystemGroupedBackground
    }
}
