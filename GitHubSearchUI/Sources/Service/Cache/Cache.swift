//
//  Cache.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/06.
//  Copyright © 2019 presto. All rights reserved.
//

import Foundation

protocol Cache {
  associatedtype Key

  associatedtype Value

  static func set(_: Value, forKey: Key)

  static func get(forKey: Key) -> Value?
}

final class ImageCache: Cache {
  private static var storage = NSCache<NSString, NSData>()

  static func set(_ data: Data, forKey key: String) {
    storage.setObject(data as NSData, forKey: key as NSString)
  }

  static func get(forKey key: String) -> Data? {
    guard let object = storage.object(forKey: key as NSString) else { return nil }
    return object as Data
  }
}
