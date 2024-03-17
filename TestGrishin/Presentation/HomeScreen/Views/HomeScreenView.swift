//
//  HomeScreenView.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI

struct HomeScreenView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let insets = EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
    }
    
    // MARK: - Public Properties
    
    var model: HomeScreenModel
    
    // MARK: - Private Properties
    
    @State private var selection = 2
    
    // MARK: - Body
    
    var body: some View {
        TabView(selection: $selection) {
            HomeTradeView(homeModel: model, tradeModel: model.tradeModel)
                .tabItem {
                    VStack {
                        Image("traderTabBar").renderingMode(.template)
                        Text("Trade")
                            .font(Font.interMedium(size: 10))
                    }
                }
                .tag(1)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.tabBarColor, for: .tabBar)
            HomeTopView(homeModel: model, topModel: model.topModel)
                .tabItem {
                    VStack {
                        Image("topTabBar").renderingMode(.template)
                        Text("Top")
                            .font(Font.interMedium(size: 10))
                    }
                }
                .tag(2)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.tabBarColor, for: .tabBar)
        }
        .tint(Color.appGreen)
    }
}
