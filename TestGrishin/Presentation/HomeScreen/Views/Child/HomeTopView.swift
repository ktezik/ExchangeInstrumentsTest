//
//  HomeTopView.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI

struct HomeTopView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let verticalSpacing: CGFloat = 29
        static let topInset: CGFloat = 20
        static let topRadius: CGFloat = 8
        static let horizontalInsets: CGFloat = 12
    }
    
    // MARK: - Public Properties
    
    var homeModel: HomeScreenModel
    @State var topModel: [HomeTopModel]
    
    // MARK: - Private Properties
    
    var cellColor = Color.primaryColor
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack(spacing: Constants.verticalSpacing) {
                Text("TOP 10 Traders")
                    .font(.interBold(size: 22))
                    .foregroundStyle(Color.white)
                    .padding(.top, Constants.topInset)
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HomeTopCell(
                            width: geometry.size.width,
                            color: homeModel.getTopCellColor()
                        )
                        ForEach(topModel.indices, id: \.self) { index in
                            let cellModel = topModel[index]
                            HomeTopCell(
                                isInitialCell: false,
                                width: geometry.size.width,
                                index: String(index + 1),
                                flagImage: cellModel.flag,
                                name: cellModel.name,
                                deposit: cellModel.depositTitle,
                                profit: cellModel.profitTitle,
                                color: homeModel.getTopCellColor()
                            )
                        }
                    }
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: Constants.topRadius,
                            style: .continuous
                        )
                    )
                    .padding(
                        .horizontal,
                        Constants.horizontalInsets
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.primaryColor)
        .onReceive(homeModel.$topModel) { newTopModel in
            topModel = newTopModel
        }
    }
}
