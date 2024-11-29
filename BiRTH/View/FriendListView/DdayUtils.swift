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
    func calculateDday(birth: Date?) -> Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let currentYear = calendar.component(.year, from: today)

        // 시간 정보 제거 및 기본값 설정
        let normalizedBirth = birth.map { calendar.startOfDay(for: $0) } ?? today
        
        // 현재 연도에 해당하는 생일 계산
        guard let birthDayThisYear = calendar.date(bySetting: .year, value: currentYear, of: normalizedBirth) else {
            print("Failed to calculate birthDayThisYear")
            return Int.max
        }
        
        print("Birth Day This Year: \(birthDayThisYear)")
        
        // D-day 계산
        let components = calendar.dateComponents([.day], from: today, to: birthDayThisYear)
        if let daysUntil = components.day {
            print("Days Until: \(daysUntil)")
            return daysUntil >= 0 ? daysUntil : (365 + daysUntil) // 다음 해 생일 처리
        }

        print("Error in calculating components")
        return Int.max // 에러 처리용 기본값
    }
}
