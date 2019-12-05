//
//  MeetingRoomModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/05.
//  Copyright © 2019 presto. All rights reserved.
//

import Foundation

struct MeetingRoomModel: Decodable {
  struct Reservation: Decodable {
    let startTime: String

    let endTime: String
  }

  let name: String

  let location: String

  let reservations: [Reservation]
}

extension MeetingRoomModel.Reservation {
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

