//
//  AvailableMeetingRoomViewModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import RxRelay
import RxSwift

import RxRelay
import RxSwift

protocol AvailableMeetingRoomViewModelProtocol {
  var input: AvailableMeetingRoomViewModelInputProtocol { get }

  var output: AvailableMeetingRoomViewModelOutputProtocol { get }
}

protocol AvailableMeetingRoomViewModelInputProtocol {
  func setAvailableMeetingRooms(_ model: AvailableMeetingRoomModel)
}

protocol AvailableMeetingRoomViewModelOutputProtocol {
  var availableMeetingRoomNames: Observable<[String]> { get }

  var availableMeetingRoomCountString: Observable<String> { get }
}

final class AvailableMeetingRoomViewModel {
  private let availableMeetingRoomModelRelay = BehaviorRelay<AvailableMeetingRoomModel?>(value: nil)
}

extension AvailableMeetingRoomViewModel: AvailableMeetingRoomViewModelProtocol {
  var input: AvailableMeetingRoomViewModelInputProtocol { return self }

  var output: AvailableMeetingRoomViewModelOutputProtocol { return self }
}

extension AvailableMeetingRoomViewModel: AvailableMeetingRoomViewModelInputProtocol {
  func setAvailableMeetingRooms(_ model: AvailableMeetingRoomModel) {
    availableMeetingRoomModelRelay.accept(model)
  }
}

extension AvailableMeetingRoomViewModel: AvailableMeetingRoomViewModelOutputProtocol {
  var availableMeetingRoomNames: Observable<[String]> {
    return availableMeetingRoomModelRelay.compactMap { $0 }
      .map { $0.names }
  }

  var availableMeetingRoomCountString: Observable<String> {
    return availableMeetingRoomNames
      .map { $0.count }
      .map { "\($0)" }
  }
}
