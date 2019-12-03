//
//  AvailableMeetingRoomCell.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class AvailableMeetingRoomCell: BaseCollectionViewCell {
  @IBOutlet private var meetingRoomNameLabel: UILabel!

  func configure(with meetingRoomName: String?) {
    meetingRoomNameLabel.text = meetingRoomName
  }
}
