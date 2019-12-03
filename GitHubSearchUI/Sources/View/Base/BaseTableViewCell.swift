//
//  BaseTableViewCell.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxSwift

class BaseTableViewCell: UITableViewCell {
  var disposeBag = DisposeBag()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  func setup() {}

  func bind() {}
}
