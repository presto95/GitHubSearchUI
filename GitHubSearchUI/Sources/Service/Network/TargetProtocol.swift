//
//  TargetProtocol.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import enum Alamofire.HTTPMethod
import Foundation

typealias HTTPMethod = Alamofire.HTTPMethod

protocol TargetProtocol {
  var version: TargetVersion { get }

  var method: HTTPMethod { get }

  var paths: [String] { get }

  var parameters: [String: String]? { get }

  var url: URL { get }
}

extension TargetProtocol {
  var url: URL {
    var components = URLComponents()
    components.scheme = version.scheme
    components.host = version.host
    components.path = paths.map { "/\($0)" }.joined()
    return components.url!
  }
}
