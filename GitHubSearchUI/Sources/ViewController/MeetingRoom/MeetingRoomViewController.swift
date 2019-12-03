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

  private var navigationBar = ViewFactory.instantiate(ReusableNavigationBar.self)!.then { $0.viewModel = ReusableNavigationBarModel() }
  private var availableMeetingRoomView = ViewFactory.instantiate(AvailableMeetingRoomView.self)!.then {
    $0.viewModel = AvailableMeetingRoomViewModel()
  }
  private var meetingRoomFilteringView = ViewFactory.instantiate(MeetingRoomFilteringView.self)!
  private var meetingRoomTableView = ViewFactory.instantiate(MeetingRoomTableView.self)!.then { $0.viewModel = MeetingRoomTableViewModel() }

  var viewModel: MeetingRoomViewModelProtocol!

  override func setup() {
    navigationBarContainerView.addSubview(navigationBar) { $0.edges.equalToSuperview() }
    availableMeetingRoomContainerView.addSubview(availableMeetingRoomView) { $0.edges.equalToSuperview() }
    filteringContainerView.addSubview(meetingRoomFilteringView) { $0.edges.equalToSuperview() }
    reservationRoomTableContainerView.addSubview(meetingRoomTableView) { $0.edges.equalToSuperview() }
  }

  override func bind() {
    navigationBar.rx.exitButtonDidTap
      .bind(to: rx.dismiss())
      .disposed(by: disposeBag)
  }
}
