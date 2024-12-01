//
//  BFriend+Extension.swift
//  BiRTH
//
//  Created by 이소현 on 11/29/24.
//

import Foundation
import CoreData

extension BFriend {
    /// 'birth'를 기반으로 'birthMonth'와 'birthDay'를 계산하여 저장합니다.
    func calcBirthComponents() {
        guard let birth = self.birth else {
            print("생일이 없습니다.")
            return
        }
        
        let calendar = Calendar.current
        self.birthMonth = Int16(calendar.component(.month, from: birth))
        self.birthDay = Int16(calendar.component(.day, from: birth))
        
        print("\(birth.formatted(date: .complete, time: .shortened))")
        print("\(birthMonth)")
        print("\(birthDay)")
    }
}
