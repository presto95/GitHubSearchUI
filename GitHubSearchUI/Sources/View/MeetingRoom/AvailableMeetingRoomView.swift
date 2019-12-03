//
//  AvailableMeetingRoomView.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class AvailableMeetingRoomView: BaseView {
  @IBOutlet private var availableMeetingRoomCountLabel: UILabel!
  @IBOutlet private var collectionView: UICollectionView!

  var viewModel: AvailableMeetingRoomViewModelProtocol! {
    didSet {
      bind()
    }
  }

  override func setup() {
    collectionView.do {
      $0.contentInset = .init(top: 0, left: 15, bottom: 0, right: 15)
      $0.register(AvailableMeetingRoomCell.self)
    }
  }

  override func bind() {
    Observable.just(Void())
      .subscribe(onNext: { [weak self] in
        self?.viewModel.input.setAvailableMeetingRooms(.dummy)
      })
      .disposed(by: disposeBag)

    viewModel.output.availableMeetingRoomNames
      .bind(to: collectionView.rx.items(AvailableMeetingRoomCell.self)) { row, element, cell in
        cell.configure(with: element)
      }
      .disposed(by: disposeBag)

    viewModel.output.availableMeetingRoomCountString
      .map { "\($0)" }
      .bind(to: availableMeetingRoomCountLabel.rx.text)
      .disposed(by: disposeBag)
  }
}
