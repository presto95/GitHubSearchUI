//
//  AvailableMeetingRoomModel.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

struct AvailableMeetingRoomModel {
  let names: [String]
}

extension AvailableMeetingRoomModel {
  static let dummy = AvailableMeetingRoomModel(names: ["대회의실1", "대회의실2", "회의실3", "회의실4", "회의실5", "회의실6", "회의실7", "회의실8"])
}
