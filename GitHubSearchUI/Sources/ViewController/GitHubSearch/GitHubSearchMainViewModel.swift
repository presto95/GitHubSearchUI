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
  var isLoading: Observable<Bool> { get }

  var searchResults: Observable<[GitHubUser]> { get }

  var searchDidFail: Observable<Error> { get }
}

final class GitHubSearchMainViewModel {
  private let isLoadingRelay = BehaviorRelay<Bool?>(value: nil)

  private let searchTextRelay = BehaviorRelay<String?>(value: nil)

  private let searchResultRelay = BehaviorRelay<Result<[GitHubUser], Error>?>(value: nil)

  private let gitHubAPI: GitHubAPIProtocol

  private var disposeBag = DisposeBag()

  init(gitHubAPI: GitHubAPIProtocol = GitHubAPI()) {
    self.gitHubAPI = gitHubAPI

    searchTextRelay
      .compactMap { $0 }
      .distinctUntilChanged()
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .filter { !$0.isEmpty }
      .do(onNext: { _ in self.isLoadingRelay.accept(true) })
      .flatMap { self.gitHubAPI.users(query: $0, ascending: false) }
      .do(onNext: { _ in self.isLoadingRelay.accept(false) })
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
  var isLoading: Observable<Bool> {
    return isLoadingRelay.compactMap { $0 }
  }

  var searchResults: Observable<[GitHubUser]> {
    return searchResultRelay.compactMap { $0 }
      .compactMap { $0.success }
  }

  var searchDidFail: Observable<Error> {
    return searchResultRelay.compactMap { $0 }
      .compactMap { $0.failure }
  }
}
