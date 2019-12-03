//
//  ViewControllerFactory.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class ViewControllerFactory {
  enum InstantiatingType {
    case initial
    case identifier(String)
  }

  static func instantiate<ViewController: UIViewController>(from storyboard: Storyboards,
                                                            instantiatingType: ViewControllerFactory.InstantiatingType) -> ViewController? {
    let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    switch instantiatingType {
    case .initial:
      return storyboard.instantiateInitialViewController() as? ViewController
    case let .identifier(identifier):
      return storyboard.instantiateViewController(identifier: identifier) as? ViewController
    }
  }
}
