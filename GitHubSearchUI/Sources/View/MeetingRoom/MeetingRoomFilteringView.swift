//
//  MeetingRoomFilteringView.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class MeetingRoomFilteringView: UIView {
  @IBOutlet private var radioButtonGroupContainerView: UIView!
  private var radioButtonGroup = RadioButtonGroup(frame: .zero)

  override func awakeFromNib() {
    super.awakeFromNib()
    let radioButtons: [RadioButton] = [
      ViewFactory.instantiate(RadioButton.self)!.then { $0.title = "예약가능" },
      ViewFactory.instantiate(RadioButton.self)!.then { $0.title = "외부미팅" },
      ViewFactory.instantiate(RadioButton.self)!.then { $0.title = "내 예약" }
    ]
    radioButtonGroup.setRadioButtons(radioButtons, selectedIndex: 0)
    radioButtonGroupContainerView.addSubview(radioButtonGroup) {
      $0.leading.greaterThanOrEqualToSuperview()
      $0.trailing.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
  }
}
