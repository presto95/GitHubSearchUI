//
//  ViewFactory.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class ViewFactory {
  static func instantiate<View: UIView>(_ type: View.Type) -> View? {
    return UINib(nibName: type.name, bundle: nil)
      .instantiate(withOwner: nil, options: nil).first as? View
  }
}
