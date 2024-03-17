//
//  HomeTopModel.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import UIKit

struct HomeTopModel: Hashable {
    let flag: UIImage
    let name: String
    let deposit: Int
    var profit: Int
    
    var depositTitle: String {
        "$\(deposit)"
    }
    
    var profitTitle: String {
        "$\(profit)"
    }
}

// MARK: - TestData

extension HomeTopModel {
    static func getTestData() -> [HomeTopModel] {
        [
            "Oliver",
            "Jack",
            "Harry",
            "Jacob",
            "Charley",
            "Thomas",
            "George",
            "Oscar",
            "James",
            "William"
        ].enumerated().map({
            HomeTopModel(
                flag: UIImage(named: "flag\($0.offset + 1)") ?? UIImage(),
                name: $0.element,
                deposit: Int.random(in: 300...3000),
                profit: Int.random(in: 10000...1000000)
            )
        })
    }
}
