//
//  RadioButtonGroup.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxSwift

final class RadioButtonGroup: UIStackView {
  private var radioButtons = [RadioButton]()
  private var disposeBag = DisposeBag()

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
      return radioButtons.firstIndex { $0.isSelected == true }!
    }
    set {
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
      radioButton.rx.radioButtonDidTap
        .subscribe(onNext: { [weak self] in
          self?.selectRadioButton(at: index)
        })
        .disposed(by: disposeBag)
      addArrangedSubview(radioButton)
    }
    selectRadioButton(at: selectedIndex)
  }

  private func selectRadioButton(at index: Int) {
    radioButtons.forEach { $0.isSelected = false }
    radioButtons[index].isSelected = true
  }
}
