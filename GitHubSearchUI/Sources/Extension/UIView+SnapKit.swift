//
//  UIView+SnapKit.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import SnapKit

extension UIView {
  func addSubview(_ subview: UIView, constraintMaker: (ConstraintMaker) -> Void) {
    addSubview(subview)
    subview.snp.makeConstraints(constraintMaker)
  }
}
