//
//  Reactive+UITableView.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UITableView {
  func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>(_ type: Cell.Type)
    -> (_ source: Source)
    -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
    -> Disposable where Source.Element == Sequence {
    return items(cellIdentifier: type.name, cellType: type)
  }
}
