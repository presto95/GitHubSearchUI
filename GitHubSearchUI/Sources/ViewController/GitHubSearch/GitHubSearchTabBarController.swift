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
    ((viewControllers?.first as? UINavigationController)?.topViewController as? GitHubSearchMainViewController)?
      .viewModel = GitHubSearchMainViewModel()
    ((viewControllers?.last as? UINavigationController)?.topViewController as? GitHubSearchFavoriteViewController)?
      .viewModel = GitHubSearchFavoriteViewModel()
  }
}
