//
//  HomeTopCell.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI

struct HomeTopCell: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let heightScale: CGFloat = 0.133
        static let spacingWidthScale: CGFloat = 0.0053
        static let indexWidthScale: CGFloat = 0.080
        static let flagSpacingScale: CGFloat = 0.088
        static let nameWidthScale: CGFloat = 0.178
        static let pricesSpacingScale: CGFloat = 0.055
        static let depositWidthScale: CGFloat = 0.162
        static let profitWidthScale: CGFloat = 0.197
        static let horizontalInsetScale = 0.0213
    }
    
    // MARK: - Public Properties
    
    var isInitialCell: Bool = true
    var width: CGFloat
    var index: String = "№"
    var flagImage: UIImage? = nil
    var name: String = "Name"
    var deposit: String = "Deposit"
    var profit: String = "Profit"
    var color: Color
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: width * Constants.spacingWidthScale) {
            Text(index)
                .frame(
                    maxWidth: width * Constants.indexWidthScale,
                    alignment: .leading
                )
                .foregroundStyle(isInitialCell ? .grayTitle : Color.white)
                .font(Font.interSemiBold(size: isInitialCell ? 12 : 14))
                .lineLimit(1)
                .minimumScaleFactor(0.4)
            if let flagImage {
                Image(uiImage: flagImage)
            } else {
                Text("Country")
                    .foregroundStyle(isInitialCell ? .grayTitle : Color.white)
                    .font(Font.interSemiBold(size: isInitialCell ? 12 : 14))
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
            }
            Spacer().frame(width: width * Constants.flagSpacingScale)
            Text(name)
                .frame(
                    maxWidth: width * Constants.nameWidthScale,
                    alignment: .leading
                )
                .foregroundStyle(isInitialCell ? .grayTitle : Color.white)
                .font(Font.interSemiBold(size: isInitialCell ? 12 : 14))
                .lineLimit(1)
                .minimumScaleFactor(0.4)
            Spacer().frame(width: width * Constants.pricesSpacingScale)
            Text(deposit)
                .frame(
                    maxWidth: width * Constants.depositWidthScale,
                    alignment: .trailing
                )
                .foregroundStyle(isInitialCell ? .grayTitle : Color.white)
                .font(Font.interSemiBold(size: isInitialCell ? 12 : 14))
                .lineLimit(1)
                .minimumScaleFactor(0.4)
            Spacer().frame(width: width * Constants.pricesSpacingScale)
            Text(profit)
                .frame(
                    maxWidth: width * Constants.profitWidthScale,
                    alignment: .trailing
                )
                .foregroundStyle(isInitialCell ? .grayTitle : Color.appGreen)
                .font(Font.interSemiBold(size: isInitialCell ? 12 : 14))
                .lineLimit(1)
                .minimumScaleFactor(0.4)
        }
        .padding(.horizontal, width * Constants.horizontalInsetScale)
        .frame(
            maxWidth: .infinity,
            maxHeight: width * Constants.heightScale,
            alignment: .leading
        )
        .background(color)
    }
}
