//
//  BaseCellViewModel.swift
//  TestGitHubUsers
//
//  Created by User on 2023-09-07.
//

import Foundation
import UIKit

//MARK: - Base configurable Any type UIModel protocol
protocol BaseCellAnyUIModel {
    static var cellAnyType: UIView.Type { get }
    func setupAny(cell: UIView)
}


//MARK: - Base configurable Cell UIModel protocol
/**
 To give an opportunity to configure UI elements directly in `UITableViewCell` or `UICollectionViewCell`
 we create a special protocol that has function with associated type
 that will play a role of a special View in a particular cell.
 */
protocol BaseCellUIModel: BaseCellAnyUIModel {
    associatedtype CellType: UIView
    func setup(cell: CellType)
}

extension BaseCellUIModel {
    static var cellAnyType: UIView.Type {
        return CellType.self
    }
    
    func setupAny(cell: UIView) {
        setup(cell: cell as! CellType)
    }
}
