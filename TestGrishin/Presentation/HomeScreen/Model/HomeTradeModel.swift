//
//  HomeTradeModel.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import UIKit

struct HomeTradeModel {
    var balance: Int
    var currencyPair: CurrencyPair
    var timer: String
    var investment: Int
}

// MARK: - Test data

extension HomeTradeModel {
    static func getTestData() -> HomeTradeModel {
        HomeTradeModel(
            balance: 10000,
            currencyPair: .gpb,
            timer: "00:00",
            investment: 1000
        )
    }
}
