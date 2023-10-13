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
            let tintColors: [UIColor] = [.systemPink, .systemRed, .systemTeal, .link, .systemIndigo, .systemOrange, .systemRed, .systemMint, .purple, .systemGreen]
            let tintColor = tintColors.randomElement()!
            let gradientLayer = CAGradientLayer()
            contentBackColor.addShadow(
                offset: CGSize(width: 0, height: 5),
                color: tintColor.withAlphaComponent(0.5),
                radius: 6
            )
            gradientLayer.frame = CGRect(
                x: 0,
                y: 0,
                width: contentBackColor.frame.width + 74,
                height: contentBackColor.frame.height - 6
            )
            gradientLayer.colors = [
                tintColor.withAlphaComponent(1.0).cgColor,
                tintColor.withAlphaComponent(0.6).cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.cornerRadius = 25
            
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


extension UIView {
    func addShadow(
        offset: CGSize = CGSize(width: 0, height: 2),
        color: UIColor = .black,
        radius: CGFloat = 4,
        opacity: Float = 1
    ) {
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
}


extension Int {
    static func randomUsersSinceIndex() -> String {
        return "\(Int.random(in: (1...1000)))"
    }
}
