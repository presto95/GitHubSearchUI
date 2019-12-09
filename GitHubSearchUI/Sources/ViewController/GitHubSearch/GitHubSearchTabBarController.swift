//
//  GitHubSearchTabBarController.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/05.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class GitHubSearchTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    topViewController(of: viewControllers?[0],
                      as: GitHubSearchMainViewController.self)?.viewModel = GitHubSearchMainViewModel()
    topViewController(of: viewControllers?[1],
                      as: GitHubSearchFavoriteViewController.self)?.viewModel = GitHubSearchFavoriteViewModel()
  }
}

private extension GitHubSearchTabBarController {
  func topViewController<ViewController: UIViewController>(of viewController: UIViewController?,
                                                           as type: ViewController.Type) -> ViewController? {
    return (viewController as? UINavigationController)?.topViewController as? ViewController
  }
}
