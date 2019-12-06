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

  var viewModel: GitHubSearchItemCellModelProtocol! {
    didSet {
      bindViewModel()
    }
  }

  override func setup() {
    avatarImageView.layer.cornerRadius = 10
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = .init()
    avatarImageView.image = nil
    nameLabel.text = nil
    scoreLabel.text = nil
    isFavoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
  }

  func configure(with model: GitHubUser) {
    viewModel.input.setModel(model)
  }

  override func bindViewModel() {
    viewModel.output.avatarImageData
      .map(UIImage.init)
      .bind(to: avatarImageView.rx.image)
      .disposed(by: disposeBag)

    viewModel.output.name
      .bind(to: nameLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.scoreString
      .bind(to: scoreLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.isFavorite
      .map { $0 ? "star.fill": "star" }
      .map { UIImage(systemName: $0) }
      .bind(to: isFavoriteButton.rx.image())
      .disposed(by: disposeBag)
  }
}
