//
//  DetailGitHubUserDB.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-08.
//

import Foundation

//MARK: - Main model
final class DetailGitHubUserDB: Decodable {
    let login: String!
    let id: Int
    let node_id: String!
    let avatar_url: String!
    let gravatar_id: String!
    let url: String!
    let html_url: String!
    let followers_url: String!
    let following_url: String!
    let gists_url: String!
    let starred_url: String!
    let subscriptions_url: String!
    let organizations_url: String!
    let repos_url: String!
    let events_url: String!
    let received_events_url: String!
    let type: String!
    let site_admin: Bool!
    let name: String!
    let company: String!
    let blog: String!
    let location: String!
    let email: String!
    let hireable: Bool!
    let bio: String!
    let twitter_username: String!
    let public_repos: Int!
    let public_gists: Int!
    let followers: Int!
    let following: Int!
    let created_at: String!
    let updated_at: String!
    
    init(login: String!, id: Int, node_id: String!, avatar_url: String!, gravatar_id: String!, url: String!, html_url: String!, followers_url: String!, following_url: String!, gists_url: String!, starred_url: String!, subscriptions_url: String!, organizations_url: String!, repos_url: String!, events_url: String!, received_events_url: String!, type: String!, site_admin: Bool!, name: String!, company: String!, blog: String!, location: String!, email: String!, hireable: Bool!, bio: String!, twitter_username: String!, public_repos: Int!, public_gists: Int!, followers: Int!, following: Int!, created_at: String!, updated_at: String!) {
        self.login = login
        self.id = id
        self.node_id = node_id
        self.avatar_url = avatar_url
        self.gravatar_id = gravatar_id
        self.url = url
        self.html_url = html_url
        self.followers_url = followers_url
        self.following_url = following_url
        self.gists_url = gists_url
        self.starred_url = starred_url
        self.subscriptions_url = subscriptions_url
        self.organizations_url = organizations_url
        self.repos_url = repos_url
        self.events_url = events_url
        self.received_events_url = received_events_url
        self.type = type
        self.site_admin = site_admin
        self.name = name
        self.company = company
        self.blog = blog
        self.location = location
        self.email = email
        self.hireable = hireable
        self.bio = bio
        self.twitter_username = twitter_username
        self.public_repos = public_repos
        self.public_gists = public_gists
        self.followers = followers
        self.following = following
        self.created_at = created_at
        self.updated_at = updated_at
    }
}
