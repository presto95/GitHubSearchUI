//
//  RadioButtonGroup.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxRelay
import RxSwift

final class RadioButtonGroup: UIStackView {
  private var radioButtons = [RadioButton]()
  private var disposeBag = DisposeBag()

  fileprivate let selectedIndexRelay = BehaviorRelay<Int>(value: 0)

  override init(frame: CGRect) {
    super.init(frame: frame)
    spacing = 10
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)
    spacing = 10
  }

  var selectedIndex: Int {
    get {
      return selectedIndexRelay.value
    }
    set {
      selectedIndexRelay.accept(newValue)
      selectRadioButton(at: newValue)
    }
  }

  func radioButton(at index: Int) -> RadioButton {
    return radioButtons[index]
  }

  func setRadioButtons(_ radioButtons: [RadioButton], selectedIndex: Int) {
    disposeBag = .init()
    
    radioButtons.forEach { removeArrangedSubview($0) }
    self.radioButtons = radioButtons
    radioButtons.enumerated().forEach { index, radioButton in
      addArrangedSubview(radioButton)
      bindRadioButton(radioButton, index: index)
    }
    selectRadioButton(at: selectedIndex)
  }

  private func bindRadioButton(_ button: RadioButton, index: Int) {
    button.rx.radioButtonDidTap
      .subscribe(onNext: { [weak self] in
        self?.selectRadioButton(at: index)
      })
      .disposed(by: disposeBag)
  }

  private func selectRadioButton(at index: Int) {
    radioButtons.forEach { $0.isSelected = false }
    radioButtons[index].isSelected = true
  }
}

extension Reactive where Base: RadioButtonGroup {
  var selectedIndex: Observable<Int> {
    return base.selectedIndexRelay.asObservable()
  }
}
