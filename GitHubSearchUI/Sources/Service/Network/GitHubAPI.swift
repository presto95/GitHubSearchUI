//
//  GitHubAPI.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/05.
//  Copyright © 2019 presto. All rights reserved.
//

import Alamofire

import RxSwift

typealias Result = Swift.Result

protocol GitHubAPIProtocol {
  func users(query: String, page: Int, ascending: Bool) -> Observable<Result<[GitHubUser], Error>>
}

final class GitHubAPI: GitHubAPIProtocol {
  private let networkManager: NetworkManagerProtocol

  init(networkManager: NetworkManagerProtocol = NetworkManager()) {
    self.networkManager = networkManager
  }

  func users(query: String, page: Int, ascending: Bool) -> Observable<Result<[GitHubUser], Error>> {
    let target = GitHubSearchUsersTarget(query: query, page: page, sort: nil, order: .init(ascending: ascending))
    return .create { [weak self] observer in
      self?.networkManager
        .request(target)
        .response(to: GitHubSearchUsersResponse.self) { response in
          let result = response.result
          let mappedResult = result.map { GitHubUser.make(from: $0) }
          switch mappedResult {
          case let .success(success):
            observer.onNext(.success(success))
          case let .failure(error):
            observer.onNext(.failure(error))
          }
          observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}

final class MockGitHubAPI: GitHubAPIProtocol {
  func users(query: String, page: Int, ascending: Bool) -> Observable<Result<[GitHubUser], Error>> {
    return .just(.success(DummyData.gitHubUsers))
  }
}
