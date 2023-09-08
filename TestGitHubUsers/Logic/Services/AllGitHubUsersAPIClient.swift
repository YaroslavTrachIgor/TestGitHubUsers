//
//  AllGitHubUsersAPIClient.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-08.
//

import Foundation

//MARK: - GitHub Users API client protocol
protocol AllGitHubUsersAPIClientProtocol {
    func getUsers() async throws -> [GitHubUserDB]?
}


//MARK: - GitHub Users API client
final class AllGitHubUsersAPIClient: APIHelper, AllGitHubUsersAPIClientProtocol {
    
    //MARK: Internal
    func getUsers() async throws -> [GitHubUserDB]? {
        do {
            let data = try await self.get()
            if let response: [GitHubUserDB] = JSONHelper.decode(data) {
                return response
            } else {
                return nil
            }
        } catch {
            throw APIError.ACRequestError.unknownApplicationAPIGetError
        }
    }
}
