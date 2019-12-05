//
//  GitHubFavoriteUserFileManager.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/06.
//  Copyright © 2019 presto. All rights reserved.
//

import Foundation

final class GitHubFavoriteUserFileManager: PersistenceManagerProtocol {
  func save<Encode: Encodable>(_ data: Encode) throws {
    let encoded = try JSONEncoder().encode(data)
    try encoded.write(to: fileURL)
  }

  func read<Decode: Decodable>() throws -> Decode {
    let data = try Data(contentsOf: fileURL)
    return try JSONDecoder().decode(Decode.self, from: data)
  }

  private var fileURL: URL {
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = directoryURL
      .appendingPathComponent("github_favorite_users")
      .appendingPathExtension("json")
    return fileURL
  }
}

