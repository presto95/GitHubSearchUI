//
//  GitHubSearchItemCellModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/06.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol GitHubSearchItemCellModelProtocol {
  var input: GitHubSearchItemCellModelInputProtocol { get }

  var output: GitHubSearchItemCellModelOutputProtocol { get }
}

protocol GitHubSearchItemCellModelInputProtocol {
  func setModel(_ model: GitHubUser)
}

protocol GitHubSearchItemCellModelOutputProtocol {
  var avatarImageData: Observable<Data> { get }

  var name: Observable<String> { get }

  var scoreString: Observable<String> { get }

  var isFavorite: Observable<Bool> { get }
}

final class GitHubSearchItemCellModel {
  private let gitHubUserModelRelay = BehaviorRelay<GitHubUser?>(value: nil)
}

extension GitHubSearchItemCellModel: GitHubSearchItemCellModelProtocol {
  var input: GitHubSearchItemCellModelInputProtocol { return self }

  var output: GitHubSearchItemCellModelOutputProtocol { return self }
}

extension GitHubSearchItemCellModel: GitHubSearchItemCellModelInputProtocol {
  func setModel(_ model: GitHubUser) {
    gitHubUserModelRelay.accept(model)
  }
}

extension GitHubSearchItemCellModel: GitHubSearchItemCellModelOutputProtocol {
  var avatarImageData: Observable<Data> {
    return gitHubUserModelRelay.compactMap { $0 }
      .map { $0.avatarURL }
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
    return gitHubUserModelRelay.compactMap { $0 }
      .map { $0.username }
  }

  var scoreString: Observable<String> {
    return gitHubUserModelRelay.compactMap { $0 }
      .map { "\($0.score)" }
  }

  var isFavorite: Observable<Bool> {
    return gitHubUserModelRelay.compactMap { $0 }
      .map { $0.isFavorite }
  }
}
