//
//  MeetingRoomTableView.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class MeetingRoomTableView: BaseView {
  @IBOutlet private var tableView: UITableView!

  var viewModel: MeetingRoomTableViewModelProtocol! {
    didSet {
      bindViewModel()
    }
  }

  override func setup() {
    tableView.do {
      $0.register(MeetingRoomTableCell.self)
      $0.contentInset = .top(-5)
    }
  }

  override func bindViewModel() {
    viewModel.input.setMeetingRoomInfo(DummyData.meetingRoomModel)

    viewModel.output.meetingRoomInfo
      .bind(to: tableView.rx.items(MeetingRoomTableCell.self)) { _, model, cell in
        cell.configure(with: model)
      }
      .disposed(by: disposeBag)
  }
}
