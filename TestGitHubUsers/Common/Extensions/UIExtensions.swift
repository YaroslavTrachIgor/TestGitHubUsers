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


//MARK: - Color Fast methods
extension UIColor {
    
    //MARK: Static
    /**
     An array of pre-defined tint colors.
     
     - Note: These colors are carefully chosen to align with Apple's Human Interface Guidelines
             and provide a visually appealing user interface.
     */
    static let randomTintColors: [UIColor] = [
        .systemPink,
        .systemRed,
        .link,
        .systemIndigo,
        .systemOrange,
        .systemPurple,
        .systemGreen
    ]
}


//MARK: - Fast View methods
public extension UIView {
    
    //MARK: Public
    /**
     Adds a shadow effect to the UIView.
     
     - Parameters:
        - offset: The shadow's offset from the view.
            -  Default: `CGSize(width: 0, height: 2)`
        - color: The color of the shadow.
            - Default: `.black`
        - radius: The blur radius of the shadow.
            - Default: `4`
        - opacity: The opacity of the shadow.
            - Default: `1`
     */
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
    
    /**
     Applies a gradient layer to the UIView with customizable direction.
     
     This method adds a gradient layer to the UIView, 
     creating a visually appealing and dynamic background.
     You can specify the starting and ending points of the gradient,
     and it will automatically select a random tint color from a predefined list to create the gradient effect.

     - Parameters:
        - startPoint: The starting point of the gradient, defined as a CGPoint.
            - Default: CGPoint(x: 0.0, y: 0.5)
        - endPoint: The ending point of the gradient, defined as a CGPoint.
            - Default: CGPoint(x: 1.0, y: 0.5)
     */
    func addGradient(
        tintColor: UIColor,
        startPoint: CGPoint = CGPoint(x: 0.0, y: 0.5),
        endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)
    ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(
            x: 0, y: 0,
            width: frame.width + 74,
            height: frame.height - 6
        )
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.cornerRadius = 25
        gradientLayer.colors = [
            tintColor.withAlphaComponent(1.0).cgColor,
            tintColor.withAlphaComponent(0.6).cgColor
        ]
        backgroundColor = .clear
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
