//
//  CurrencyPairCell.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI

struct CurrencyPairCell: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let radius: CGFloat = 12
        static let height: CGFloat = 54
    }
    
    // MARK: - Public Properties
    
    var isSelected: Bool
    var currencyPair: CurrencyPair
    var action: (CurrencyPair) -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action(currencyPair)
        } label: {
            Text(currencyPair.cellTitle)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(Font.interSemiBold(size: 14))
                .foregroundStyle(Color.white)
        }
        .buttonStyle(.automatic)
        .frame(maxWidth: .infinity, maxHeight: Constants.height)
        .background(isSelected ? Color.appGreen : Color.balance)
        .clipShape(
            RoundedRectangle(
                cornerRadius: Constants.radius,
                style: .continuous
            )
        )
    }
}

// MARK: - Preview

#Preview {
    CurrencyPairCell(isSelected: false, currencyPair: .eur) { _ in }
}
