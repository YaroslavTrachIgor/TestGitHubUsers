//
//  FoundationExtensions.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-08.
//

import Foundation

//MARK: - Fast URL Response checks
public extension HTTPURLResponse {
    
    //MARK: Public
    var isValidStatusCode: Bool {
        return (200...299).contains(self.statusCode)
    }
}


//MARK: - Fast Int methods
extension Int {
    
    //MARK: Public
    static func randomUsersSinceIndex() -> String {
        return "\(Int.random(in: (1...1000)))"
    }
}
