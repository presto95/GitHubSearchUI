//
//  GitHubSearchUsersTarget.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

struct GitHubSearchUsersTarget: TargetProtocol {
  enum Order: String {
    case ascending = "asc"

    case descending = "desc"

    init(ascending: Bool) {
      self = ascending ? .ascending : .descending
    }
  }

  var version: TargetVersion {
    return .gitHub
  }

  var method: HTTPMethod {
    return .get
  }

  var paths: [String] {
    return ["search", "users"]
  }

  var parameters: [String : String]?

  init(query: String, sort: String? = nil, order: Order? = nil) {
    var parameters = [String: String]()
    parameters["q"] = query
    if let sort = sort {
      parameters["sort"] = sort
    }
    if let order = order {
      parameters["order"] = order.rawValue
    }
    self.parameters = parameters
  }
}
