//
//  MeetingRoomModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import Foundation

struct MeetingRoomInfo: Decodable {
  struct Reservation: Decodable {
    let startTime: String

    let endTime: String
  }

  let name: String

  let location: String

  let reservations: [Reservation]
}

extension MeetingRoomInfo.Reservation {
  var startHour: Int {
    let hourString = startTime[startTime.startIndex ..< startTime.index(startTime.startIndex, offsetBy: 2)]
    return Int(hourString)!
  }

  var startMinute: Int {
    let minuteString = startTime[startTime.index(startTime.startIndex, offsetBy: 2) ..< startTime.endIndex]
    return Int(minuteString)!
  }

  var endHour: Int {
    let hourString = endTime[endTime.startIndex ..< endTime.index(endTime.startIndex, offsetBy: 2)]
    return Int(hourString)!
  }

  var endMinute: Int {
    let minuteString = endTime[endTime.index(endTime.startIndex, offsetBy: 2) ..< endTime.endIndex]
    return Int(minuteString)!
  }
}

extension MeetingRoomInfo {
  static let dummy: [MeetingRoomInfo] = {
    let dataURL = Bundle.main.url(forResource: "meeting_room", withExtension: "json")!
    let data = try! Data(contentsOf: dataURL)
    return try! JSONDecoder().decode([MeetingRoomInfo].self, from: data)
  }()
}
