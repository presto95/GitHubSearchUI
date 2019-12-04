//
//  BaseViewController.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
  var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bindViewModel()
  }

  func setup() {}

  func bindViewModel() {}
}
