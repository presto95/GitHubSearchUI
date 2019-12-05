//
//  ReusableNavigationBarModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol ReusableNavigationBarModelProtocol {
  var input: ReusableNavigationBarModelInputProtocol { get }

  var output: ReusableNavigationBarModelOutputProtocol { get }
}

protocol ReusableNavigationBarModelInputProtocol {
  func setDate(_ date: Date)
}

protocol ReusableNavigationBarModelOutputProtocol {
  var dateString: Observable<String> { get }
}

final class ReusableNavigationBarModel {
  private let dateRelay = BehaviorRelay<Date?>(value: nil)
}

extension ReusableNavigationBarModel: ReusableNavigationBarModelProtocol {
  var input: ReusableNavigationBarModelInputProtocol { return self }

  var output: ReusableNavigationBarModelOutputProtocol { return self }
}

extension ReusableNavigationBarModel: ReusableNavigationBarModelInputProtocol {
  func setDate(_ date: Date) {
    dateRelay.accept(date)
  }
}

extension ReusableNavigationBarModel: ReusableNavigationBarModelOutputProtocol {
  var dateString: Observable<String> {
    let formatter = DateFormatter().then {
      $0.dateFormat = "MM월 dd일 (eee)"
      $0.locale = .korea
    }
    return dateRelay.compactMap { $0 }
      .map { formatter.string(from: $0) }
  }
}
