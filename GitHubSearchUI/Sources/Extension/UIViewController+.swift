//
//  UIViewController+.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/09.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

extension UIViewController {
  static func instantiate<ViewController: UIViewController>(from storyboard: Storyboards,
                                                            type: ViewController.Type) -> ViewController {
    let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    return storyboard.instantiateViewController(identifier: type.name) as! ViewController
  }
}
