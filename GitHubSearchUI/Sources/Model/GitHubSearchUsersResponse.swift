//
//  GitHubSearchUsersResponse.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import Foundation

struct GitHubSearchUsersResponse: Decodable {
  struct Item: Decodable {
    let id: Int

    let login: String

    let avatarURL: String

    let score: Double

    private enum CodingKeys: String, CodingKey {
      case id

      case login

      case avatarURL = "avatar_url"

      case score
    }
  }

  let totalCount: Int

  let incompleteResults: Bool

  let items: [Item]

  private enum CodingKeys: String, CodingKey {
    case totalCount = "total_count"

    case incompleteResults = "incomplete_results"

    case items
  }
}
