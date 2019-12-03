//
//  NSObject+.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import Foundation

extension NSObject {
  var name: String {
    return NSStringFromClass(type(of: self))
  }

  static var name: String {
    return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
  }
}
