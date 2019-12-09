//
//  DummyData.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/05.
//  Copyright © 2019 presto. All rights reserved.
//

import Foundation

struct DummyData {
  static let meetingRoomModel: [MeetingRoomModel] = {
    let dataURL = Bundle.main.url(forResource: "meeting_room", withExtension: "json")!
    let data = try! Data(contentsOf: dataURL)
    return try! JSONDecoder().decode([MeetingRoomModel].self, from: data)
  }()

  static let gitHubUsers: [GitHubUser] = {
    let user = GitHubUser(id: 1, avatarURLString: "https://avatars0.githubusercontent.com/u/29768423?v=4", username: "presto95", score: 808.262)
    return .init(repeating: user, count: 20)
  }()

  static let availableMeetingRooms: AvailableMeetingRoomModel = {
    .init(names: ["대회의실1", "대회의실2", "회의실3", "회의실4", "회의실5", "회의실6", "회의실7", "회의실8"])
  }()
}
