//
//  RadioButton.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class RadioButton: UIStackView {
  @IBOutlet fileprivate var radioButton: UIButton!
  @IBOutlet fileprivate var titleLabel: UILabel!

  var isSelected: Bool {
    get {
      return radioButton.isSelected
    }
    set {
      radioButton.isSelected = newValue
    }
  }

  var title: String? {
    get {
      return titleLabel.text
    }
    set {
      titleLabel.text = newValue
    }
  }
}

extension Reactive where Base: RadioButton {
  var isSelected: Binder<Bool> {
    return .init(base) { target, isSelected in
      target.radioButton.isSelected = isSelected
    }
  }

  var title: Binder<String?> {
    return .init(base) { target, title in
      target.titleLabel.text = title
    }
  }

  var radioButtonDidTap: ControlEvent<Void> {
    return base.radioButton.rx.tap
  }
}
