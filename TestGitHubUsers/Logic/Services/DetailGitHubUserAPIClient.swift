//
//  DetailGitHubUserAPIClient.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-08.
//

import Foundation

//MARK: - GitHub User API client protocol
protocol DetailGitHubUserAPIClientProtocol {
    func getUser() async throws -> DetailGitHubUserDB?
}

//MARK: - GitHub Users API client
final class DetailGitHubUserAPIClient: APIHelper, DetailGitHubUserAPIClientProtocol {
    
    //MARK: Internal
    func getUser() async throws -> DetailGitHubUserDB? {
        do {
            let data = try await self.get()
            if let response: DetailGitHubUserDB = JSONHelper.decode(data) {
                return response
            } else {
                return nil
            }
        } catch {
            throw APIError.ACRequestError.unknownApplicationAPIGetError
        }
    }
}
