//
//  MeetingRoomTableCell.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class MeetingRoomTableCell: BaseTableViewCell {
  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var locationLabel: UILabel!
  @IBOutlet private var timeBars: [UIView]!

  func configure(with meetingRoomInfo: MeetingRoomInfo) {
    nameLabel.text = meetingRoomInfo.name
    locationLabel.text = meetingRoomInfo.location
    meetingRoomInfo.reservations.forEach {
      let startHour = $0.startHour
      let endHour = $0.endHour
      let startTimeBarIndex = startHour - 9
      let endTimeBarIndex = endHour - 9
      for timeBarIndex in startTimeBarIndex ..< endTimeBarIndex {
        timeBars[timeBarIndex].backgroundColor = .secondarySystemBackground
      }
    }
  }
}
