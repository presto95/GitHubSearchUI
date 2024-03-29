//
//  ReusableNavigationBar.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

@IBDesignable
final class MeetingRoomNavigationBar: BaseView {
  @IBOutlet fileprivate var dateLabel: UILabel!
  @IBOutlet fileprivate var settingButton: UIButton!
  @IBOutlet fileprivate var exitButton: UIButton!

  var viewModel: MeetingRoomNavigationBarModel! {
    didSet {
      bindViewModel()
    }
  }

  override func bindViewModel() {
    viewModel.input.setDate(.init())

    viewModel.output.dateString
      .bind(to: dateLabel.rx.text)
      .disposed(by: disposeBag)
  }

  func configure(with date: Date) {
    viewModel.input.setDate(date)
  }
}

// MARK: - Reactive Extension

extension Reactive where Base: MeetingRoomNavigationBar {
  var date: Binder<Date> {
    return .init(base) { target, date in
      target.viewModel.setDate(date)
    }
  }

  var settingButtonDidTap: ControlEvent<Void> {
    return base.settingButton.rx.tap
  }

  var exitButtonDidTap: ControlEvent<Void> {
    return base.exitButton.rx.tap
  }
}
