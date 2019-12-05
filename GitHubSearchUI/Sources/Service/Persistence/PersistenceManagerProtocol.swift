//
//  PersistenceManagerProtocol.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/05.
//  Copyright © 2019 presto. All rights reserved.
//

protocol PersistenceManagerProtocol {
  func save<Encode: Encodable>(_: Encode) throws

  func read<Decode: Decodable>() throws -> Decode
}
