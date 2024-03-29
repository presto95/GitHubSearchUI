//
//  CALayer+.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/34269399/how-to-control-shadow-spread-and-blur
extension CALayer {
  func applySketchShadow(color: UIColor = .black,
                         alpha: Float = 0.5,
                         x: CGFloat = 0,
                         y: CGFloat = 2,
                         blur: CGFloat = 4,
                         spread: CGFloat = 0) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
