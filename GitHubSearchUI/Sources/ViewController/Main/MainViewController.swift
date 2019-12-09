//
//  MainViewController.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import Then

final class MainViewController: BaseViewController {
  @IBOutlet private var gitHubSearchButton: UIButton!
  @IBOutlet private var meetingRoomButton: UIButton!

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    gitHubSearchButton.layer.cornerRadius = gitHubSearchButton.bounds.height / 2
    meetingRoomButton.layer.cornerRadius = meetingRoomButton.bounds.height / 2
  }

  override func bindViewModel() {
    gitHubSearchButton.rx.tap
      .compactMap {
        UIViewController
          .instantiate(from: .gitHubSearch, type: GitHubSearchTabBarController.self).then {
            $0.modalPresentationStyle = .fullScreen
          }
      }
      .bind(to: rx.present())
      .disposed(by: disposeBag)

    meetingRoomButton.rx.tap
      .compactMap {
        UIViewController
          .instantiate(from: .meetingRoom, type: MeetingRoomViewController.self).then {
            $0.modalPresentationStyle = .fullScreen
          }
      }
      .bind(to: rx.present())
      .disposed(by: disposeBag)
  }
}
