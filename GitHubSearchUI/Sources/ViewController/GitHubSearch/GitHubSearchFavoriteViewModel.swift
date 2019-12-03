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

}

protocol GitHubSearchFavoriteViewModelOutputProtocol {

}

final class GitHubSearchFavoriteViewModel {

}

extension GitHubSearchFavoriteViewModel: GitHubSearchFavoriteViewModelProtocol {
  var input: GitHubSearchFavoriteViewModelInputProtocol { return self }

  var output: GitHubSearchFavoriteViewModelOutputProtocol { return self }
}

extension GitHubSearchFavoriteViewModel: GitHubSearchFavoriteViewModelInputProtocol {

}

extension GitHubSearchFavoriteViewModel: GitHubSearchFavoriteViewModelOutputProtocol {

}
