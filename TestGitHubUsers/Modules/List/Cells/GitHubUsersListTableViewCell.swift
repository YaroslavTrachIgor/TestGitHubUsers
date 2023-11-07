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
    @IBOutlet weak var gistsLabel: UILabel!
    @IBOutlet weak var titleLabal: UILabel! {
        didSet {
            titleLabal.textColor = .white
            titleLabal.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.textColor = .systemGray6
            subtitleLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        }
    }
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        }
    }
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var contentBackColor: UIView! {
        didSet {
            let tintColor = UIColor.randomTintColors.randomElement()!
            let gradientLayer = CAGradientLayer()
            contentBackColor.addShadow(
                offset: CGSize(width: 0, height: 5),
                color: tintColor.withAlphaComponent(0.5),
                radius: 6
            )
            contentBackColor.addGradient(tintColor: tintColor)
            contentBackColor.backgroundColor = .clear
            contentBackColor.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .systemGroupedBackground
    }
}
