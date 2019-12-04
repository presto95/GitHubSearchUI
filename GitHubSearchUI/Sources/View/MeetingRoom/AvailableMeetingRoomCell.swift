//
//  AvailableMeetingRoomCell.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class AvailableMeetingRoomCell: BaseCollectionViewCell {
  @IBOutlet private var contentsView: UIView!
  @IBOutlet private var meetingRoomNameLabel: UILabel!

  override func setup() {
    contentsView.layer.applySketchShadow(color: .black, alpha: 0.05, x: 0, y: 4, blur: 6, spread: 0)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    meetingRoomNameLabel.text = nil
  }

  func configure(with meetingRoomName: String?) {
    meetingRoomNameLabel.text = meetingRoomName
  }
}
