//
//  GitHubSearchItemCell.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class GitHubSearchItemCell: BaseTableViewCell {
  @IBOutlet private var avatarImageView: UIImageView!
  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var scoreLabel: UILabel!
  @IBOutlet private var isFavoriteImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
