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
      $0.contentInset = .init(top: -5, left: 0, bottom: 0, right: 0)
//      $0.rx.setDelegate(self)
//        .disposed(by: disposeBag)
    }
  }

  override func bindViewModel() {
    Observable.just(Void())
      .subscribe(onNext: { [weak self] in
        self?.viewModel.input.setMeetingRoomInfo(MeetingRoomInfo.dummy)
      })
      .disposed(by: disposeBag)

    viewModel.output.meetingRoomInfo
      .bind(to: tableView.rx.items(MeetingRoomTableCell.self)) { _, model, cell in
        cell.configure(with: model)
      }
      .disposed(by: disposeBag)
  }
}
