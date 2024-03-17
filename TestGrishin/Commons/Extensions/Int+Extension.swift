//
//  Int+Extension.swift
//  TestGrishin
//
//  Created by Иван Гришин on 17.03.2024.
//

import Foundation

extension Int {
    func getInvestmentFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
