//
//  HomeScreenModel.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI

protocol HomeScreenModelDelegate: AnyObject {
    func errorReport(_ error: Error)
}

final class HomeScreenModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var topModel = HomeTopModel.getTestData().sorted(by: { $0.profit > $1.profit })
    @Published var tradeModel = HomeTradeModel.getTestData()
    @Published var currencySelectedPairIndex: IndexPath?
    let currencyPairModel = CurrencyPair.getTestData()
    
    weak var delegate: HomeScreenModelDelegate?
    
    // MARK: - Private Properties
    
    private var topCellColor: Color = Color.cellGray
    
    // MARK: - Initialization
    
    init(delegate: HomeScreenModelDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Public Methods
    
    func reportError(_ error: Error?) {
        guard let error else { return }
        delegate?.errorReport(error)
    }
    
    func updateTopModel() {
        topCellColor = Color.cellGray
        let updatedModel = updateTopModelProfit()
        topModel = updatedModel.sorted(by: { $0.profit > $1.profit })
    }
    
    func getTopCellColor() -> Color {
        let currentColor = topCellColor
        topCellColor = topCellColor == .cellGray ? .primaryColor : .cellGray
        return currentColor
    }
    
    func updateCurrencyPair(indexPath: IndexPath, and model: CurrencyPair) {
        currencySelectedPairIndex = indexPath
        tradeModel.currencyPair = model
    }
    
    func getCurrencyPairIndex() -> IndexPath? {
        if let currencySelectedPairIndex {
            return currencySelectedPairIndex
        } else {
            guard
                let sectionIndex = currencyPairModel.firstIndex(where: { $0.contains(tradeModel.currencyPair) }),
                let itemIndex = currencyPairModel[sectionIndex].firstIndex(of: tradeModel.currencyPair)
            else {
                return nil
            }
            let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
            self.currencySelectedPairIndex = indexPath
            return indexPath
        }
    }
    
    func plusInvestmentValue() {
        tradeModel.investment += 10
    }
    
    func minusInvestmentValue() {
        tradeModel.investment -= 10
    }
    
    func updateTimer(string text: String) {
        tradeModel.timer = text
    }
    
    func updateInvestmentValue(_ textValue: String) {
        guard let value = Int(textValue) else { return }
        tradeModel.investment = value
    }
    
    // MARK: - Private Methods
    
    private func updateTopModelProfit() -> [HomeTopModel] {
        topModel.map { model in
            var model = model
            model.profit += Int.random(in: -50...150)
            return model
        }
    }
}
