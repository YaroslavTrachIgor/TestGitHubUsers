//
//  GitHubUserDetailViewController.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import UIKit

//MARK: - Constants
private extension GitHubUserDetailViewController {
    
    //MARK: Private
    enum Constants {
        enum UI {
            enum View {
                
                //MARK: Static
                static let baseBackgroundColor = UIColor.secondarySystemBackground
            }
            enum Label {
                
                //MARK: Static
                static let baseNoEmailPhrase = "No Email"
                static let baseNofFollowersPrefix =  "# of Followers: "
                static let baseNofFollowingPrefix = "# of Following: "
            }
        }
    }
}


//MARK: - ViewController protocol
protocol GitHubUserDetailViewControllerProtocol {
    func setupMainUI()
    func show(uiModel: DetailGitHubUserCellUIModel)
    func updateFollowers(with followers: [GitHubUserCellUIModel])
}


//MARK: - Main ViewController
final class GitHubUserDetailViewController: UIViewController, GitHubUserDetailViewControllerProtocol {

    //MARK: Public
    var presenter: GitHubUserDetailPresenterProtocol?
    
    //MARK: Private
    private var followersRows = [GitHubUserCellUIModel]()
    
    //MARK: @IBOutlets
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentBackgroundView: UIView!
    @IBOutlet private weak var avatarIconImageView: UIImageView!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    @IBOutlet private weak var gistsLabel: UILabel!
    @IBOutlet private weak var followersTableView: UITableView!
    @IBOutlet private weak var followersTableShadowView: UIView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onViewDidLoad()
    }
    
    //MARK: View Controller protocol
    func setupMainUI() {
        setupNavigationBar()
        setupFollowersTableView()
        setupFollowersTableShadowView()
        setupContentBackgroundView()
        view.backgroundColor = Constants.UI.View.baseBackgroundColor
    }
    
    func show(uiModel: DetailGitHubUserCellUIModel) {
        urlLabel.text = uiModel.url
        titleLabel.text = uiModel.login
        gistsLabel.text = uiModel.gists
        followersLabel.text = uiModel.followers
        followingLabel.text = uiModel.following
        backgroundImageView.downloadImage(with: uiModel.avatarURL)
        avatarIconImageView.downloadImage(with: uiModel.avatarURL)
    }
    
    func updateFollowers(with followersRows: [GitHubUserCellUIModel]) {
        self.followersRows = followersRows
        self.followersTableView.reloadData()
    }
}


//MARK: - Main methods
private extension GitHubUserDetailViewController {
    
    //MARK: Private
    func setupNavigationBar() {
        title = nil
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupContentBackgroundView() {
        let maskedCorners: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let backgroundColor = Constants.UI.View.baseBackgroundColor
        contentBackgroundView.backgroundColor = backgroundColor
        contentBackgroundView.layer.cornerRadius = 40
        contentBackgroundView.layer.maskedCorners = maskedCorners
    }
    
    func setupFollowersTableView() {
        let backgroundColor = Constants.UI.View.baseBackgroundColor
        let cellKey = String(describing: GitHubUsersListTableViewCell.self)
        let cellNib = UINib(nibName: cellKey, bundle: nil)
        followersTableView.register(cellNib, forCellReuseIdentifier: cellKey)
        followersTableView.backgroundColor = backgroundColor
        followersTableView.separatorColor = .clear
        followersTableView.rowHeight = 155
        followersTableView.delegate = self
        followersTableView.dataSource = self
    }
    
    func setupFollowersTableShadowView() {
        let backgroundColor = Constants.UI.View.baseBackgroundColor
        followersTableShadowView.backgroundColor = backgroundColor
        followersTableShadowView.addShadow(color: backgroundColor, radius: 3, opacity: 1)
    }
}


//MARK: - TableView protocols extension
extension GitHubUserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Internal
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followersRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let uiModel = followersRows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withModel: uiModel, indexPath: indexPath)
        return cell
    }
}
