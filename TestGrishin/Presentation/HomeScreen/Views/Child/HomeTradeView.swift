//
//  HomeTradeView.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI
import WebKit
import Combine

struct HomeTradeView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let topInset: CGFloat = 20
        static let titleHeight: CGFloat = 27
        
        static let balanceHeight: CGFloat = 54
        static let balanceTopInset: CGFloat = 15
        static let webTopInset: CGFloat = 25
        
        static let balanceHorizontalInset: CGFloat = 30
        static let balanceRadius: CGFloat = 12
        static let webScale: CGFloat = 0.468
        static let extraKeyboardHeightScale: CGFloat = 0.20
    }
    
    // MARK: - Public Properties
    
    var homeModel: HomeScreenModel
    @State var tradeModel: HomeTradeModel
    
    // MARK: - Private Properties
    
    private let webView = WebView()
    @State private var keyboardHeight: CGFloat = 0
    @State private var keyboardIsOpen: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        Text("Trade")
                            .font(.interBold(size: 22))
                            .foregroundStyle(Color.white)
                            .padding(.top, Constants.topInset)
                        Spacer().frame(height: Constants.balanceTopInset)
                        balance
                        Spacer().frame(height: Constants.webTopInset)
                        webView
                            .background(Color.red)
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: geometry.size.height * Constants.webScale
                            )
                            .onAppear() {
                                homeModel.reportError(
                                    webView.loadURL(
                                        urlString: tradeModel.currencyPair.webLink
                                    )
                                )
                            }
                    }
                    TradeButtons(
                        model: homeModel,
                        screenHeight: geometry.size.height,
                        currencyPairTitle: tradeModel.currencyPair.buttonTitle,
                        timerText: tradeModel.timer,
                        investmentText: tradeModel.investment.getInvestmentFormat(),
                        keyboardIsOpen: $keyboardIsOpen
                    )
                    .padding(.top, getButtonsTopInset(with: geometry.size.height))
                    .onReceive(Publishers.keyboardHeight) { value in
                        withAnimation {
                            keyboardHeight = value
                            keyboardIsOpen = value != 0
                        }
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.tradeBackground)
            .onReceive(homeModel.$tradeModel) { newTradeModel in
                tradeModel = newTradeModel
            }
        }
    }
    
    // MARK: - Balance
    
    var balance: some View {
        VStack(spacing: 7) {
            Text("Balance")
                .font(Font.interMedium(size: 12))
                .foregroundStyle(Color.lightGrayTitle)
                .padding(.top, 5)
            Text("10 000")
                .font(Font.interSemiBold(size: 16))
                .foregroundStyle(Color.white)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
        .background(Color.balance)
        .clipShape(
            RoundedRectangle(
                cornerRadius: Constants.balanceRadius,
                style: .continuous
            )
        )
        .padding(.horizontal, Constants.balanceHorizontalInset)
    }
    
    // MARK: - Private Methods
    
    private func getButtonsTopInset(with height: CGFloat) -> CGFloat {
        var topInset = Constants.topInset + Constants.titleHeight
        topInset += Constants.balanceTopInset + Constants.balanceHeight
        topInset += Constants.webTopInset + height * Constants.webScale
        let extraHeight = keyboardHeight * Constants.extraKeyboardHeightScale
        return topInset - keyboardHeight + extraHeight
    }
}

// MARK: - Preview

#Preview {
    HomeTradeView(
        homeModel: HomeScreenModel(delegate: nil),
        tradeModel: HomeTradeModel.getTestData()
    )
}
