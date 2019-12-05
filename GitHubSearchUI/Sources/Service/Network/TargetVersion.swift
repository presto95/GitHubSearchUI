//
//  TargetVersion.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

enum TargetVersion {
  case gitHub
}

extension TargetVersion {
  var scheme: String {
    switch self {
    case .gitHub:
      return "https"
    }
  }

  var host: String {
    switch self {
    case .gitHub:
      return "api.github.com"
    }
  }
}
