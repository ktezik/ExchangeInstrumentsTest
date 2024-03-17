//
//  CurrencyPair.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import Foundation

enum CurrencyPair {
    case gpb
    case eur
    
    var cellTitle: String {
        switch self {
        case .gpb:
            "GPB / USD"
        case .eur:
            "EUR / USD"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .gpb:
            "GPB/USD"
        case .eur:
            "EUR/USD"
        }
    }
    
    var webLink: String {
        switch self {
        case .gpb:
            "https://www.tradingview.com/chart/?symbol=NASDAQ%3AGBP"
        case .eur:
            "https://www.tradingview.com/chart/?symbol=BMFBOVESPA%3AEUR1%21"
        }
    }
}

// MARK: - Test data

extension CurrencyPair {
    static func getTestData() -> [[CurrencyPair]] {
        [
            [.eur, .gpb],
            [.eur, .eur],
            [.gpb, .eur],
            [.eur, .eur],
            [.eur, .gpb],
            [.eur, .eur],
            [.gpb, .eur]
        ]
    }
}
