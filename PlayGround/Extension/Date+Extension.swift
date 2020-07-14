//
//  Date+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/24.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

fileprivate let dateFormatter: DateFormatter = {
  let dateFmt = DateFormatter()
  dateFmt.timeZone = TimeZone.current
  return dateFmt
}()

extension Date {
  func toString(_ format: String? = "yyyy-MM-dd") -> String {
    if let fmt = format {
      dateFormatter.dateFormat = fmt
    }
    return dateFormatter.string(from: self)
  }
}
