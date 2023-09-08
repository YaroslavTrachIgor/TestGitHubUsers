//
//  UIExtensions.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation
import UIKit

//MARK: - TableView Fast methods
extension UITableView {
    
    //MARK: Internal
    func dequeueReusableCell(withModel model: BaseCellAnyUIModel, indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: type(of: model).cellAnyType)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        model.setupAny(cell: cell)
        return cell
    }
}


//MARK: - Fast ImageView methods
public extension UIImageView {
    
    //MARK: Public
    /// This is needed to quickly download an image form the Internet
    /// or from Cache and place it into an image view.
    ///
    /// *This function will be used in UICollectionViewCell or UITableViewCell set up files.*
    /// *That is, in the files where we have only one data row (URL) available.*
    /// - Parameters:
    ///    - url: image URL.
    func downloadImage(with url: URL?) {
        guard let url = url else { return }
        let key = url.absoluteString
        let cache = CacheManager.defaults
        if let cachedImage = cache.getImage(forKey: key) {
            self.image = cachedImage
        } else {
            Task {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.isValidStatusCode else {
                        throw APIError.ACRequestError.invalidDataError
                    }
                    guard let image = UIImage(data: data) else { return }
                    cache.saveImage(image: image, forKey: key)
                    /**
                     After downloading an image from the web via the background thread,
                     we use `MainActor`to move to the main thread to set up the UI Element.
                     */
                    await MainActor.run {
                        self.image = image
                    }
                } catch {
                    image = nil
                }
            }
        }
    }
}
