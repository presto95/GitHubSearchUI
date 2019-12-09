//
//  MeetingRoomFilteringView.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class MeetingRoomFilteringView: BaseView {
  @IBOutlet private var radioButtonGroupContainerView: UIView!

  private var radioButtonGroup = RadioButtonGroup(frame: .zero)

  override func setup() {
    let radioButtons: [RadioButton] = [
      UIView.instantiate(RadioButton.self).then { $0.title = "예약가능" },
      UIView.instantiate(RadioButton.self).then { $0.title = "외부미팅" },
      UIView.instantiate(RadioButton.self).then { $0.title = "내 예약" },
    ]
    radioButtonGroup.setRadioButtons(radioButtons)
    radioButtonGroupContainerView.addSubview(radioButtonGroup) {
      $0.leading.greaterThanOrEqualToSuperview()
      $0.trailing.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
  }
}
