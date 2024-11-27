//
//  DdayUtils.swift
//  BiRTH
//
//  Created by Hajin on 11/27/24.
//

import Foundation

class DdayUtils {
    /// 선택된 생일 날짜와 오늘의 날짜를 비교하여 D-Day 텍스트를 반환.
    /// 생일이 오늘이면 "D-Day"를 반환하고, 오늘보다 멀다면 "D-daysUntil" 형식으로 반환.
    /// 생일 날짜가 없으면 "저장된 날짜가 없어요."를 반환.
    func calculateDday(birth: Date?) -> String {
        guard let birthdate = birth else {
            return "저장된 날짜가 없어요."
        }

        let today = Calendar.current.startOfDay(for: Date())
        let targetDate = Calendar.current.startOfDay(for: birthdate)
        let components = Calendar.current.dateComponents([.day], from: today, to: targetDate)
        if let daysUntil = components.day {
            return daysUntil == 0 ? "D-Day" : "D-\(daysUntil)"
        } else {
            return "daysUntil is nil"
        }
    }
}
