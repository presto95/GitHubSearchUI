//
//  GitHubSearchMainViewController.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxViewController

final class GitHubSearchMainViewController: BaseViewController {
  @IBOutlet private var exitButton: UIBarButtonItem!
  @IBOutlet private var tableView: UITableView!

  private var indicatorView: UIActivityIndicatorView!
  private let searchController = UISearchController(searchResultsController: nil)

  private var searchBar: UISearchBar {
    return searchController.searchBar
  }

  var viewModel: GitHubSearchMainViewModelProtocol!

  override func setup() {
    searchController.obscuresBackgroundDuringPresentation = false
    searchBar.placeholder = "Username"
    tableView.register(GitHubSearchItemCell.self)
    navigationItem.searchController = searchController
    indicatorView = UIActivityIndicatorView(style: .large).then {
      $0.color = .label
      $0.hidesWhenStopped = true
      $0.stopAnimating()
    }
    view.addSubview(indicatorView) { $0.center.equalToSuperview() }
  }

  override func bindViewModel() {
    searchBar.rx.text.orEmpty
      .subscribe(onNext: { [weak self] text in
        self?.viewModel.input.setSearchText(text)
      })
      .disposed(by: disposeBag)

    exitButton.rx.tap
      .bind(to: rx.dismiss())
      .disposed(by: disposeBag)

    viewModel.output.searchResults
      .bind(to: tableView.rx.items(GitHubSearchItemCell.self)) { _, model, cell in
        cell.viewModel = GitHubSearchItemCellModel()
        cell.configure(with: model)
      }
      .disposed(by: disposeBag)

    viewModel.output.searchDidFail
      .subscribe(onNext: { [weak self] error in
        let alertController = AlertControllerBuilder()
          .alert(title: "", message: "정보를 불러오지 못했습니다.")
          .action(title: "확인")
          .build()
        self?.present(alertController, animated: true, completion: nil)
      })
      .disposed(by: disposeBag)

    viewModel.output.isLoading
      .subscribe(onNext: { [weak self] isLoading in
        if isLoading {
          self?.indicatorView.startAnimating()
        } else {
          self?.indicatorView.stopAnimating()
        }
      })
      .disposed(by: disposeBag)
  }
}
