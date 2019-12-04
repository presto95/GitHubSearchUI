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

  private var numberOfTimeBars: Int {
    return timeBars.count
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    contentsView.layer.applySketchShadow(color: .black, alpha: 0.05, x: 0, y: 4, blur: 6, spread: 0)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = nil
    locationLabel.text = nil
    timeBars.forEach { $0.backgroundColor = .systemBlue }
  }

  func configure(with meetingRoomInfo: MeetingRoomInfo) {
    nameLabel.text = meetingRoomInfo.name
    locationLabel.text = meetingRoomInfo.location
    meetingRoomInfo.reservations.forEach {
      let startTimeBarIndex = timeBarIndex(from: (hour: $0.startHour, minute: $0.startMinute))
      let endTimeBarIndex = timeBarIndex(from: (hour: $0.endHour, minute: $0.endMinute))
      (startTimeBarIndex ..< endTimeBarIndex).forEach {
        timeBars[$0].backgroundColor = .secondarySystemBackground
      }
    }
    addCurrentTimePointerView()
  }
}

private extension MeetingRoomTableCell {
  func timeBarIndex(from time: (hour: Int, minute: Int)) -> Int {
    var resultIndex = 0
    let hourIndex = (time.hour - 9) * 2
    resultIndex += hourIndex
    if !(0 ..< 30).contains(time.minute) {
      resultIndex += 1
    }
    return resultIndex
  }

  func addCurrentTimePointerView() {
    let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
    guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
    let currentTimeBarIndex = timeBarIndex(from: (hour: hour, minute: minute))
    let timePointerView = ViewFactory.instantiate(CurrentTimePointerView.self)!
    let timePointerViewIndex = currentTimeBarIndex > numberOfTimeBars - 1
      ? numberOfTimeBars - 1
      : currentTimeBarIndex
    addSubview(timePointerView) {
      $0.leading.equalTo(timeBars[timePointerViewIndex].snp.leading)
      $0.bottom.equalTo(timeBars[timePointerViewIndex].snp.bottom)
      $0.width.equalTo(43)
      $0.height.equalTo(28)
    }
  }
}
