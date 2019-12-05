//
//  GitHubSearchFavoriteViewModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol GitHubSearchFavoriteViewModelProtocol {
  var input: GitHubSearchFavoriteViewModelInputProtocol { get }

  var output: GitHubSearchFavoriteViewModelOutputProtocol { get }
}

protocol GitHubSearchFavoriteViewModelInputProtocol {
  func setFavoriteUsers()
}

protocol GitHubSearchFavoriteViewModelOutputProtocol {
  var favoriteUsers: Observable<[GitHubUser]> { get }
}

final class GitHubSearchFavoriteViewModel {
  private let favoriteUsersRelay = BehaviorRelay<[GitHubUser]?>(value: nil)

  private let persistenceManager: PersistenceManagerProtocol

  init(persistenceManager: PersistenceManagerProtocol = GitHubFavoriteUserFileManager()) {
    self.persistenceManager = persistenceManager
  }
}

extension GitHubSearchFavoriteViewModel: GitHubSearchFavoriteViewModelProtocol {
  var input: GitHubSearchFavoriteViewModelInputProtocol { return self }

  var output: GitHubSearchFavoriteViewModelOutputProtocol { return self }
}

extension GitHubSearchFavoriteViewModel: GitHubSearchFavoriteViewModelInputProtocol {
  func setFavoriteUsers() {
    let savedData: [GitHubUser]? = try? persistenceManager.read()
    favoriteUsersRelay.accept(savedData ?? [])
  }
}

extension GitHubSearchFavoriteViewModel: GitHubSearchFavoriteViewModelOutputProtocol {
  var favoriteUsers: Observable<[GitHubUser]> {
    return favoriteUsersRelay.compactMap { $0 }
  }
}
