//
//  GitHubSearchFavoriteViewController.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class GitHubSearchFavoriteViewController: BaseViewController {
  @IBOutlet private var tableView: UITableView!
  @IBOutlet private var exitButton: UIBarButtonItem!

  private var emptyPresentationLabel: UILabel!

  var viewModel: GitHubSearchFavoriteViewModelProtocol!

  override func setup() {
    tableView.register(GitHubSearchItemCell.self)
  }

  override func bindViewModel() {
    rx.viewWillAppear
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.input.setFavoriteUsers()
      })
      .disposed(by: disposeBag)

    viewModel.output.favoriteUsers
      .bind(to: tableView.rx.items(GitHubSearchItemCell.self)) { _, model, cell in
        cell.viewModel = GitHubSearchItemCellModel()
        cell.configure(with: model)
      }
      .disposed(by: disposeBag)

    viewModel.output.favoriteUsers
      .filter { $0.isEmpty }
      .subscribe(onNext: { [weak self] _ in
        self?.addEmptyPresentationLabel()
      })
      .disposed(by: disposeBag)

    viewModel.output.favoriteUsers
      .filter { !$0.isEmpty }
      .subscribe(onNext: { [weak self] _ in
        self?.removeEmptyPresentationLabel()
      })
      .disposed(by: disposeBag)

    exitButton.rx.tap
      .bind(to: rx.dismiss())
      .disposed(by: disposeBag)
  }
}

private extension GitHubSearchFavoriteViewController {
  func addEmptyPresentationLabel() {
    guard emptyPresentationLabel == nil else { return }
    emptyPresentationLabel = UILabel().then {
      $0.text = "즐겨찾기한 정보가 없습니다."
    }
    view.addSubview(emptyPresentationLabel) {
      $0.center.equalToSuperview()
    }
  }

  func removeEmptyPresentationLabel() {
    guard emptyPresentationLabel != nil else { return }
    emptyPresentationLabel.removeFromSuperview()
    emptyPresentationLabel = nil
  }
}
