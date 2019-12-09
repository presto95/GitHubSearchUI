//
//  GitHubSearchMainViewModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol GitHubSearchMainViewModelInputProtocol {
  func setSearchText(_ text: String)
  func searchMoreUsers()
}

protocol GitHubSearchMainViewModelOutputProtocol {
  var isLoading: Observable<Bool> { get }
  var searchResults: Observable<[GitHubUser]> { get }
  var searchDidFail: Observable<Error> { get }
}

final class GitHubSearchMainViewModel {
  private let isLoadingRelay = BehaviorRelay<Bool?>(value: nil)
  private let searchTextRelay = BehaviorRelay<String?>(value: nil)
  private let pageRelay = BehaviorRelay<Int>(value: 1)
  private let searchResultRelay = BehaviorRelay<Result<[GitHubUser], Error>?>(value: nil)

  private let persistenceService = PersistenceService()
  private let gitHubAPI: GitHubAPIProtocol
  private var disposeBag = DisposeBag()

  init(gitHubAPI: GitHubAPIProtocol = GitHubAPI()) {
    self.gitHubAPI = gitHubAPI

    let searchTextObservable = searchTextRelay
      .compactMap { $0 }
      .distinctUntilChanged()
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .filter { !$0.isEmpty }

    Observable.combineLatest(searchTextObservable, pageRelay)
      .do(onNext: { [weak self] _ in self?.isLoadingRelay.accept(true) })
      .flatMap { [weak self] in
        self?.gitHubAPI.users(query: $0, page: $1, ascending: false) ?? .empty()
      }
      .do(onNext: { [weak self] _ in self?.isLoadingRelay.accept(false) })
      .subscribe(onNext: { [weak self] result in
        switch result {
        case let .success(success):
          if let current = self?.searchResultRelay.value?.success {
            let final = current + success
            self?.searchResultRelay.accept(.success(final))
          } else {
            self?.searchResultRelay.accept(.success(success))
          }
        case let .failure(error):
          self?.searchResultRelay.accept(.failure(error))
        }
      })
      .disposed(by: disposeBag)
  }
}

extension GitHubSearchMainViewModel: GitHubSearchMainViewModelInputProtocol {
  func setSearchText(_ text: String) {
    resetPage()
    searchTextRelay.accept(text)
  }

  func searchMoreUsers() {
    increasePage()
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

private extension GitHubSearchMainViewModel {
  func increasePage() {
    let currentPage = pageRelay.value
    pageRelay.accept(currentPage + 1)
  }

  func resetPage() {
    pageRelay.accept(1)
  }
}

protocol GitHubSearchMainViewModelProtocol {
  var input: GitHubSearchMainViewModelInputProtocol { get }
  var output: GitHubSearchMainViewModelOutputProtocol { get }
}

extension GitHubSearchMainViewModel: GitHubSearchMainViewModelProtocol {
  var input: GitHubSearchMainViewModelInputProtocol { return self }
  var output: GitHubSearchMainViewModelOutputProtocol { return self }
}
