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
      bindViewModel()
    }
  }

  override func setup() {
    let layout = UICollectionViewFlowLayout().then {
      $0.scrollDirection = .horizontal
      $0.estimatedItemSize = .init(width: 100, height: 46)
      $0.minimumLineSpacing = 0
      $0.minimumInteritemSpacing = 0
    }
    collectionView.do {
      $0.contentInset = .horizontal(13)
      $0.register(AvailableMeetingRoomCell.self)
      $0.collectionViewLayout = layout
    }
  }

  override func bindViewModel() {
    Observable.just(Void())
      .subscribe(onNext: { [weak self] in
        self?.viewModel.input.setAvailableMeetingRooms(DummyData.availableMeetingRooms)
      })
      .disposed(by: disposeBag)

    viewModel.output.availableMeetingRoomNames
      .bind(to: collectionView.rx.items(AvailableMeetingRoomCell.self)) { _, element, cell in
        cell.configure(with: element)
      }
      .disposed(by: disposeBag)

    viewModel.output.numberOfAvailableMeetingRoomsString
      .bind(to: availableMeetingRoomCountLabel.rx.text)
      .disposed(by: disposeBag)
  }
}
