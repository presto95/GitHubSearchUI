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

  let avatarURL: URL

  let username: String
  
  let score: Double

  let isFavorite: Bool = false

  static func make(from response: GitHubSearchUsersResponse) -> [GitHubUser] {
    return response.items
      .map { GitHubUser(id: $0.id,
                        avatarURL: URL(string: $0.avatarURL)!,
                        username: $0.login,
                        score: $0.score) }
  }
}
