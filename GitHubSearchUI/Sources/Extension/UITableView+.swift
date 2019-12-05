//
//  UITableView+.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

extension UITableView {
  func register<Cell: UITableViewCell>(_ type: Cell.Type) {
    register(.init(nibName: type.name, bundle: nil), forCellReuseIdentifier: type.name)
  }
}
