//
//  UICollectionView+.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

extension UICollectionView {
  func register<Cell: UICollectionViewCell>(_ type: Cell.Type) {
    register(.init(nibName: type.name, bundle: nil), forCellWithReuseIdentifier: type.name)
  }
}
