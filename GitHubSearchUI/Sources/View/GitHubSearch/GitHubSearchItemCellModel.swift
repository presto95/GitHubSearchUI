//
//  GitHubSearchItemCellModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/06.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol GitHubSearchItemCellModelInputProtocol {
  func setFavoriteUser(_ model: GitHubUser)
  func updateFavoriteStatus()
}

protocol GitHubSearchItemCellModelOutputProtocol {
  var avatarImageData: Observable<Data> { get }
  var name: Observable<String> { get }
  var scoreString: Observable<String> { get }
  var isFavorite: Observable<Bool> { get }
}

final class GitHubSearchItemCellModel {
  private let gitHubFavoriteUserModelRelay = BehaviorRelay<GitHubUser?>(value: nil)
  private let isFavoriteRelay = BehaviorRelay<Bool?>(value: nil)

  private let persistenceService = PersistenceService()
}

extension GitHubSearchItemCellModel: GitHubSearchItemCellModelInputProtocol {
  func setFavoriteUser(_ model: GitHubUser) {
    gitHubFavoriteUserModelRelay.accept(model)
    if persistenceService.contains(model) {
      isFavoriteRelay.accept(true)
    } else {
      isFavoriteRelay.accept(false)
    }
  }

  func updateFavoriteStatus() {
    guard let model = gitHubFavoriteUserModelRelay.value else { return }
    if persistenceService.contains(model) {
      persistenceService.delete(model)
      isFavoriteRelay.accept(false)
    } else {
      persistenceService.save(model)
      isFavoriteRelay.accept(true)
    }
  }
}

extension GitHubSearchItemCellModel: GitHubSearchItemCellModelOutputProtocol {
  var avatarImageData: Observable<Data> {
    return gitHubFavoriteUserModelRelay.compactMap { $0 }
      .map { $0.avatarURLString }
      .compactMap { URL(string: $0) }
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
      .flatMap { avatarURL -> Observable<Data> in
        if let cachedData = ImageCache.get(forKey: avatarURL.absoluteString) {
          return Observable.just(cachedData)
        } else {
          let imageData = try! Data(contentsOf: avatarURL)
          ImageCache.set(imageData, forKey: avatarURL.absoluteString)
          return Observable.just(imageData)
        }
      }
  }

  var name: Observable<String> {
    return gitHubFavoriteUserModelRelay.compactMap { $0 }
      .compactMap { $0.username }
  }

  var scoreString: Observable<String> {
    return gitHubFavoriteUserModelRelay.compactMap { $0 }
      .map { "\($0.score)" }
  }

  var isFavorite: Observable<Bool> {
    return isFavoriteRelay.compactMap { $0 }
  }
}

protocol GitHubSearchItemCellModelProtocol {
  var input: GitHubSearchItemCellModelInputProtocol { get }
  var output: GitHubSearchItemCellModelOutputProtocol { get }
}

extension GitHubSearchItemCellModel: GitHubSearchItemCellModelProtocol {
  var input: GitHubSearchItemCellModelInputProtocol { return self }
  var output: GitHubSearchItemCellModelOutputProtocol { return self }
}
