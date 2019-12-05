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
  @IBOutlet private var isFavoriteButton: UIButton!

  override func setup() {
    avatarImageView.layer.cornerRadius = 10
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    avatarImageView.image = nil
    nameLabel.text = nil
    scoreLabel.text = nil
    isFavoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
  }

  func configure(with model: GitHubUser) {
    DispatchQueue.global().async {
      let imageData = try! Data(contentsOf: model.avatarURL)
      DispatchQueue.main.async {
        self.avatarImageView.image = UIImage(data: imageData)
      }
    }
    nameLabel.text = model.username
    scoreLabel.text = "\(model.score)"
  }
}
