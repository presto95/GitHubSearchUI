//
//  MeetingRoomTableCell.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import UIKit

final class MeetingRoomTableCell: BaseTableViewCell {
  @IBOutlet private var contentsView: UIView!
  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var locationLabel: UILabel!
  @IBOutlet private var timeBars: [UIView]!

  private var currentTimePointerView: CurrentTimePointerView!

  override func setup() {
    contentsView.layer
      .applySketchShadow(color: .black, alpha: 0.05, x: 0, y: 4, blur: 6, spread: 0)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = nil
    locationLabel.text = nil
    timeBars.forEach { $0.backgroundColor = .systemBlue }
    currentTimePointerView?.removeFromSuperview()
    currentTimePointerView = nil
  }

  func configure(with meetingRoomModel: MeetingRoomModel) {
    nameLabel.text = meetingRoomModel.name
    locationLabel.text = meetingRoomModel.location
    meetingRoomModel.reservations.forEach {
      setTimeBar(from: (hour: $0.startHour, minute: $0.startMinute),
                 to: (hour: $0.endHour, minute: $0.endMinute))
    }
    addCurrentTimePointerView()
  }
}

private extension MeetingRoomTableCell {
  func setTimeBar(from startTime: (hour: Int, minute: Int), to endTime: (hour: Int, minute: Int)) {
    let startTimeBarIndex = timeBarIndex(fromHour: startTime.hour, minute: startTime.minute)
    let endTimeBarIndex = timeBarIndex(fromHour: endTime.hour, minute: endTime.minute)
    (startTimeBarIndex ..< endTimeBarIndex).forEach {
      timeBars[$0].backgroundColor = .secondarySystemBackground
    }
  }

  func timeBarIndex(fromHour hour: Int, minute: Int) -> Int {
    var resultIndex = hourIndexForTimeBars(hour)
    if !isMinuteInHalfHour(minute) {
      resultIndex += 1
    }
    return resultIndex
  }

  func hourIndexForTimeBars(_ hour: Int) -> Int {
    return (hour - 9) * 2
  }

  func isMinuteInHalfHour(_ minute: Int) -> Bool {
    return (0 ..< 30).contains(minute)
  }

  func addCurrentTimePointerView() {
    let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
    guard let hour = dateComponents.hour,
      let minute = dateComponents.minute,
      hour >= 9, hour <= 18 else { return }
    let currentTimeBarIndex = timeBarIndex(fromHour: hour, minute: minute)
    currentTimePointerView = UIView.instantiate(CurrentTimePointerView.self)
    let currentTimePointerViewIndex = currentTimeBarIndex > timeBars.count - 1
      ? timeBars.count - 1
      : currentTimeBarIndex
    addSubview(currentTimePointerView) {
      $0.centerX.equalTo(timeBars[currentTimePointerViewIndex].snp.leading)
      $0.bottom.equalTo(timeBars[currentTimePointerViewIndex].snp.bottom)
      $0.width.equalTo(43)
      $0.height.equalTo(28)
    }
  }
}
