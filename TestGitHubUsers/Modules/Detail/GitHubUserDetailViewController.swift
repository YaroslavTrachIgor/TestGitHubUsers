//
//  GitHubUserDetailViewController.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import UIKit

//MARK: - ViewController protocol
protocol GitHubUserDetailViewControllerProtocol {
    func show(uiModel: DetailGitHubUserCellUIModel)
}

//MARK: - Main ViewController
final class GitHubUserDetailViewController: UIViewController, GitHubUserDetailViewControllerProtocol {

    var presenter: GitHubUserDetailPresenterProtocol?
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var avatarIconImageView: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad()
    }
    
    //MARK: View Controller protocol
    func show(uiModel: DetailGitHubUserCellUIModel) {
        titleLabel.text = uiModel.login
        emailLabel.text = uiModel.email ?? "No Email"
        followersLabel.text = "# of Followers: " + String(uiModel.followers ?? 0)
        followingLabel.text = "# of Followings: " + String(uiModel.following ?? 0)
        avatarIconImageView.downloadImage(with: uiModel.avatarURL)
    }
}


