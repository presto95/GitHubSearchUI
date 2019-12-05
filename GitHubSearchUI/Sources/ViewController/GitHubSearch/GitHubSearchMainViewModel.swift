//
//  GitHubSearchMainViewModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol GitHubSearchMainViewModelProtocol {
  var input: GitHubSearchMainViewModelInputProtocol { get }

  var output: GitHubSearchMainViewModelOutputProtocol { get }
}

protocol GitHubSearchMainViewModelInputProtocol {
  func setSearchText(_ text: String)
}

protocol GitHubSearchMainViewModelOutputProtocol {
  var searchResults: Observable<[GitHubUser]> { get }

  var searchDidFail: Observable<Error> { get }
}

final class GitHubSearchMainViewModel {
  private let searchTextRelay = BehaviorRelay<String?>(value: nil)

  private let searchResultRelay = BehaviorRelay<Result<[GitHubUser], Error>?>(value: nil)

  private let gitHubAPI: GitHubAPIProtocol

  private var disposeBag = DisposeBag()

  init(gitHubAPI: GitHubAPIProtocol = GitHubAPI()) {
    self.gitHubAPI = gitHubAPI

    searchTextRelay
      .compactMap { $0 }
      .filter { !$0.isEmpty }
      .distinctUntilChanged()
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .flatMap { self.gitHubAPI.users(query: $0, ascending: false) }
      .bind(to: searchResultRelay)
      .disposed(by: disposeBag)
  }
}

extension GitHubSearchMainViewModel: GitHubSearchMainViewModelProtocol {
  var input: GitHubSearchMainViewModelInputProtocol { return self }

  var output: GitHubSearchMainViewModelOutputProtocol { return self }
}

extension GitHubSearchMainViewModel: GitHubSearchMainViewModelInputProtocol {
  func setSearchText(_ text: String) {
    searchTextRelay.accept(text)
  }
}

extension GitHubSearchMainViewModel: GitHubSearchMainViewModelOutputProtocol {
  var searchResults: Observable<[GitHubUser]> {
    return searchResultRelay.compactMap { $0 }
      .compactMap { $0.success }
  }

  var searchDidFail: Observable<Error> {
    return searchResultRelay.compactMap { $0 }
      .compactMap { $0.failure }
  }
}
