//
//  UIView+.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

extension UIView {
  func addSubviews(_ subviews: UIView...) {
    subviews.forEach { addSubview($0) }
  }
}
