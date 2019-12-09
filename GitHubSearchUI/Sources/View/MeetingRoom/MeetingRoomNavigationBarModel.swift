//
//  ReusableNavigationBarModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol MeetingRoomNavigationBarModelInputProtocol {
  func setDate(_ date: Date)
}

protocol MeetingRoomNavigationBarModelOutputProtocol {
  var dateString: Observable<String> { get }
}

final class MeetingRoomNavigationBarModel {
  private let dateRelay = BehaviorRelay<Date?>(value: nil)
}

extension MeetingRoomNavigationBarModel: MeetingRoomNavigationBarModelInputProtocol {
  func setDate(_ date: Date) {
    dateRelay.accept(date)
  }
}

extension MeetingRoomNavigationBarModel: MeetingRoomNavigationBarModelOutputProtocol {
  var dateString: Observable<String> {
    let formatter = DateFormatter().then {
      $0.dateFormat = "MM월 dd일 (eee)"
      $0.locale = .korea
    }
    return dateRelay.compactMap { $0 }
      .map { formatter.string(from: $0) }
  }
}

protocol MeetingRoomNavigationBarModelProtocol {
  var input: MeetingRoomNavigationBarModelInputProtocol { get }
  var output: MeetingRoomNavigationBarModelOutputProtocol { get }
}

extension MeetingRoomNavigationBarModel: MeetingRoomNavigationBarModelProtocol {
  var input: MeetingRoomNavigationBarModelInputProtocol { return self }
  var output: MeetingRoomNavigationBarModelOutputProtocol { return self }
}
