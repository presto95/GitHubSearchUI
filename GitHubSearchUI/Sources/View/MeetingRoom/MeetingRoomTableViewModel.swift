//
//  MeetingRoomTableViewModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol MeetingRoomTableViewModelProtocol {
  var input: MeetingRoomTableViewModelInputProtocol { get }

  var output: MeetingRoomTableViewModelOutputProtocol { get }
}

protocol MeetingRoomTableViewModelInputProtocol {
  func setMeetingRoomInfo(_ model: [MeetingRoomInfo])
}

protocol MeetingRoomTableViewModelOutputProtocol {
  var meetingRoomInfo: Observable<[MeetingRoomInfo]> { get }
}

final class MeetingRoomTableViewModel {
  private let meetingRoomInfoRelay = BehaviorRelay<[MeetingRoomInfo]?>(value: nil)
}

extension MeetingRoomTableViewModel: MeetingRoomTableViewModelProtocol {
  var input: MeetingRoomTableViewModelInputProtocol { return self }

  var output: MeetingRoomTableViewModelOutputProtocol { return self }
}

extension MeetingRoomTableViewModel: MeetingRoomTableViewModelInputProtocol {
  func setMeetingRoomInfo(_ model: [MeetingRoomInfo]) {
    meetingRoomInfoRelay.accept(model)
  }
}

extension MeetingRoomTableViewModel: MeetingRoomTableViewModelOutputProtocol {
  var meetingRoomInfo: Observable<[MeetingRoomInfo]> {
    return meetingRoomInfoRelay.compactMap { $0 }
  }
}
