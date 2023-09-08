//
//  CacheManager.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-08.
//

import Foundation
import UIKit

//MARK: - Manager for fast access to the Device's Cache
final class CacheManager {
    
    //MARK: Static
    static let defaults = CacheManager()
    
    //MARK: Private
    private var imageCache = NSCache<NSString, UIImage>()
    
    
    //MARK: Initialization
    private init() {}
    
    //MARK: Public
    func saveImage(image: UIImage, forKey: String) {
        imageCache.setObject(image, forKey: forKey as NSString)
    }
    
    func getImage(forKey: String) -> UIImage? {
        imageCache.object(forKey: forKey as NSString)
    }
}
