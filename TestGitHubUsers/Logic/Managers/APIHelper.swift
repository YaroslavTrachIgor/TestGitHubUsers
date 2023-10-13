//
//  APIHelper.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-08.
//

import Foundation

//MARK: - API Errors list
public enum APIError {
    
    //MARK: Public
    public enum ACRequestError: String, Error {
        case invalidURLError = "The URL is invalid."
        case sessionError = "Session task error. Check your Wifi-Connection."
        case invalidDataError = "Model Data equals to nil. You need to check JSON model structure integrity."
        case unknownApplicationAPIGetError = "Unknown Application API Get request error. Please, try again."
    }
}


//MARK: - API Base Completion Handlers
typealias APIGetRequestCompletionHandler = ((Result<Data, APIError.ACRequestError>) -> Void)


//MARK: - API Helper protocol
protocol APIHelperProtocol {
    init(url: URL?)
    func update(with url: URL?)
    func get() async throws -> Data
}


//MARK: - Main API Helper
public class APIHelper: APIHelperProtocol {

    //MARK: Public
    var url: URL?
    var fileName: String?
    
    //MARK: Private
    private let session = URLSession(configuration: .default)
    
    
    //MARK: Initialization
    required init(url: URL?) {
        self.url = url
    }
    
    //MARK: Internal
    func update(with url: URL?) {
        self.url = url
    }
    
    /// This creates a simple `GET` URL request.
    /// - Parameter completion: gives opportunity to work in `APIClients` with content of different `Codable` models in the future.
    func get() async throws -> Data {
        guard let url = url else { throw APIError.ACRequestError.invalidURLError }
        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.isValidStatusCode else {
            throw APIError.ACRequestError.sessionError
        }
        return data
    }
}
