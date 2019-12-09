//
//  GitHubSearchFavoriteViewModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import CoreData

import RxRelay
import RxSwift

protocol GitHubSearchFavoriteViewModelInputProtocol {
  func setFavoriteUsers()
}

protocol GitHubSearchFavoriteViewModelOutputProtocol {
  var favoriteUsers: Observable<[GitHubUser]> { get }
}

final class GitHubSearchFavoriteViewModel {
  private let favoriteUsersRelay = BehaviorRelay<[GitHubUser]?>(value: nil)

  private let persistenceService = PersistenceService()
}

extension GitHubSearchFavoriteViewModel: GitHubSearchFavoriteViewModelInputProtocol {
  func setFavoriteUsers() {
    let results = persistenceService.fetch()?.map { GitHubUser.make(from: $0) }
    favoriteUsersRelay.accept(results)
  }
}

extension GitHubSearchFavoriteViewModel: GitHubSearchFavoriteViewModelOutputProtocol {
  var favoriteUsers: Observable<[GitHubUser]> {
    return favoriteUsersRelay.compactMap { $0 }
  }
}

protocol GitHubSearchFavoriteViewModelProtocol {
  var input: GitHubSearchFavoriteViewModelInputProtocol { get }
  var output: GitHubSearchFavoriteViewModelOutputProtocol { get }
}

extension GitHubSearchFavoriteViewModel: GitHubSearchFavoriteViewModelProtocol {
  var input: GitHubSearchFavoriteViewModelInputProtocol { return self }
  var output: GitHubSearchFavoriteViewModelOutputProtocol { return self }
}
