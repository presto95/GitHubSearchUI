//
//  MeetingRoomTableViewModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol MeetingRoomTableViewModelInputProtocol {
  func setMeetingRoomInfo(_ model: [MeetingRoomModel])
}

protocol MeetingRoomTableViewModelOutputProtocol {
  var meetingRoomInfo: Observable<[MeetingRoomModel]> { get }
}

final class MeetingRoomTableViewModel {
  private let meetingRoomInfoRelay = BehaviorRelay<[MeetingRoomModel]?>(value: nil)
}

extension MeetingRoomTableViewModel: MeetingRoomTableViewModelInputProtocol {
  func setMeetingRoomInfo(_ model: [MeetingRoomModel]) {
    meetingRoomInfoRelay.accept(model)
  }
}

extension MeetingRoomTableViewModel: MeetingRoomTableViewModelOutputProtocol {
  var meetingRoomInfo: Observable<[MeetingRoomModel]> {
    return meetingRoomInfoRelay.compactMap { $0 }
  }
}

protocol MeetingRoomTableViewModelProtocol {
  var input: MeetingRoomTableViewModelInputProtocol { get }
  var output: MeetingRoomTableViewModelOutputProtocol { get }
}

extension MeetingRoomTableViewModel: MeetingRoomTableViewModelProtocol {
  var input: MeetingRoomTableViewModelInputProtocol { return self }
  var output: MeetingRoomTableViewModelOutputProtocol { return self }
}
