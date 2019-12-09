//
//  GitHubUser.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/05.
//  Copyright © 2019 presto. All rights reserved.
//

import Foundation

struct GitHubUser: Codable {
  let id: Int

  let avatarURLString: String

  let username: String

  let score: Double

  static func make(from response: GitHubSearchUsersResponse) -> [GitHubUser] {
    return response.items
      .map { GitHubUser(id: $0.id,
                        avatarURLString: $0.avatarURL,
                        username: $0.login,
                        score: $0.score) }
  }

  static func make(from persistence: GitHubFavoriteUser) -> GitHubUser {
    return .init(id: Int(persistence.id),
                 avatarURLString: persistence.avatarURL ?? "",
                 username: persistence.username ?? "",
                 score: persistence.score)
  }
}
