//
//  AlertControllerBuilder.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/05.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class AlertControllerBuilder {
  private var alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

  func alert(title: String?,
             message: String?,
             style: UIAlertController.Style = .alert) -> AlertControllerBuilder {
    alertController = .init(title: title, message: message, preferredStyle: style)
    return self
  }

  func action(title: String?,
              style: UIAlertAction.Style = .default,
              completion: ((UIAlertAction) -> Void)? = nil) -> AlertControllerBuilder {
    alertController.addAction(.init(title: title, style: style, handler: completion))
    return self
  }

  func textField(configurationHandler: ((UITextField) -> Void)?) -> AlertControllerBuilder {
    alertController.addTextField(configurationHandler: configurationHandler)
    return self
  }

  func build() -> UIAlertController {
    return alertController
  }
}
