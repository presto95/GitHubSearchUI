//
//  MeetingRoomViewController.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class MeetingRoomViewController: BaseViewController {
  @IBOutlet private var navigationBarContainerView: UIView!
  @IBOutlet private var availableMeetingRoomContainerView: UIView!
  @IBOutlet private var filteringContainerView: UIView!
  @IBOutlet private var reservationRoomTableContainerView: UIView!

  private lazy var navigationBar = UIView.instantiate(MeetingRoomNavigationBar.self).then {
    $0.viewModel = MeetingRoomNavigationBarModel()
  }

  private lazy var availableMeetingRoomView = UIView.instantiate(AvailableMeetingRoomView.self).then {
    $0.viewModel = AvailableMeetingRoomViewModel()
  }

  private lazy var meetingRoomFilteringView = UIView.instantiate(MeetingRoomFilteringView.self)
  private lazy var meetingRoomTableView = UIView.instantiate(MeetingRoomTableView.self).then {
    $0.viewModel = MeetingRoomTableViewModel()
  }

  override func setup() {
    navigationBarContainerView.addContentsView(navigationBar)
    availableMeetingRoomContainerView.addContentsView(availableMeetingRoomView)
    filteringContainerView.addContentsView(meetingRoomFilteringView)
    reservationRoomTableContainerView.addContentsView(meetingRoomTableView)
  }

  override func bindViewModel() {
    navigationBar.rx.exitButtonDidTap
      .bind(to: rx.dismiss())
      .disposed(by: disposeBag)
  }
}
