//
//  MeetingRoomViewModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

protocol MeetingRoomViewModelProtocol {
  var input: MeetingRoomViewModelInputProtocol { get }

  var output: MeetingRoomViewModelOutputProtocol { get }
}

protocol MeetingRoomViewModelInputProtocol {}

protocol MeetingRoomViewModelOutputProtocol {}

final class MeetingRoomViewModel {}

extension MeetingRoomViewModel: MeetingRoomViewModelProtocol {
  var input: MeetingRoomViewModelInputProtocol { return self }

  var output: MeetingRoomViewModelOutputProtocol { return self }
}

extension MeetingRoomViewModel: MeetingRoomViewModelInputProtocol {}

extension MeetingRoomViewModel: MeetingRoomViewModelOutputProtocol {}
