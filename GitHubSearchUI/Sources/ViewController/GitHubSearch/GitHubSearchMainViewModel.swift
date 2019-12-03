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

}

protocol GitHubSearchMainViewModelOutputProtocol {

}

final class GitHubSearchMainViewModel {

}

extension GitHubSearchMainViewModel: GitHubSearchMainViewModelProtocol {
  var input: GitHubSearchMainViewModelInputProtocol { return self }

  var output: GitHubSearchMainViewModelOutputProtocol { return self }
}

extension GitHubSearchMainViewModel: GitHubSearchMainViewModelInputProtocol {

}

extension GitHubSearchMainViewModel: GitHubSearchMainViewModelOutputProtocol {

}
