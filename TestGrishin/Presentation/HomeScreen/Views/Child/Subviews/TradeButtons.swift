//
//  TradeButtons.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI
import UIKit

struct TradeButtons: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let horizontalSpacing: CGFloat = 11
        static let verticalSpacing: CGFloat = 10
        static let buttonHeightScale: CGFloat = 0.079
        static let horizontalInset: CGFloat = 30
        static let innerHorizontalInset: CGFloat = 15
        static let radius: CGFloat = 12
        static let titleHInset: CGFloat = 20
        static let buttonsTopInset: CGFloat = 16
        static let buttonsKeyboardInset: CGFloat = 21
        static let buttonsBottomInset: CGFloat = 47
    }
    
    // MARK: - Public Properties
    
    var model: HomeScreenModel
    var screenHeight: CGFloat
    @State var currencyPairTitle: String
    @State var timerText: String
    @State var investmentText: String
    @Binding var keyboardIsOpen: Bool
    @FocusState var timerDidEditing: Bool
    @FocusState var investmentDidEditing: Bool
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: Constants.verticalSpacing) {
            currencyPair
            HStack(spacing: Constants.horizontalSpacing) {
                timer
                investment
            }
            HStack(spacing: Constants.horizontalSpacing) {
                sell
                buy
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
        .padding(
            .top,
            keyboardIsOpen ? Constants.buttonsKeyboardInset : Constants.buttonsTopInset
        )
        .padding(.bottom, keyboardIsOpen ? Constants.buttonsBottomInset : 0)
        .background(keyboardIsOpen ? Color.primaryColor : .clear)
        .onReceive(model.$tradeModel) { tradeMode in
            currencyPairTitle = tradeMode.currencyPair.buttonTitle
            timerText = tradeMode.timer
            investmentText = tradeMode.investment.getInvestmentFormat()
        }
    }
    
    // MARK: - Currency pair button
    
    var currencyPair: some View {
        NavigationLink {
            HomeCurrencyPairView(
                model: model,
                selectedIndex: model.getCurrencyPairIndex()
            )
        } label: {
            ZStack {
                Text(currencyPairTitle)
                    .foregroundStyle(Color.white)
                    .font(Font.interBold(size: 16))
                Image("rightArrow")
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .trailing
                    )
                    .padding(
                        .horizontal,
                        Constants.innerHorizontalInset
                    )
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: screenHeight * Constants.buttonHeightScale
            )
            .background(Color.balance)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: Constants.radius,
                    style: .continuous
                )
            )
        }
        .buttonStyle(.automatic)
    }
    
    // MARK: - Timer
    
    var timer: some View {
        VStack {
            Text("Timer")
                .font(.interMedium(size: 12))
                .foregroundStyle(Color.lightGrayTitle)
            HStack {
                Button {
                    endTextEditing()
                    timerMinus()
                } label: {
                    Image("minusCircle")
                        .padding(.leading, Constants.innerHorizontalInset)
                }
                .buttonStyle(.plain)
                TextField("", text: $timerText) {
                }
                .onChange(of: timerText) {
                    timerText = formatTimeInput(getNumericString())
                    model.updateTimer(string: timerText)
                }
                .focused($timerDidEditing)
                .environment(\.colorScheme, .dark)
                .keyboardType(.numberPad)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
                .font(.interBold(size: 16))
                Button {
                    endTextEditing()
                    timerPlus()
                } label: {
                    Image("addCircle")
                        .padding(.trailing, Constants.innerHorizontalInset)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: screenHeight * Constants.buttonHeightScale
        )
        .background(Color.balance)
        .clipShape(
            RoundedRectangle(
                cornerRadius: Constants.radius,
                style: .continuous
            )
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: Constants.radius,
                style: .continuous
            ).stroke(
                timerDidEditing ? Color.appGreen : .clear,
                lineWidth: 1
            )
        )
    }
    
    // MARK: - Investment
    
    var investment: some View {
        VStack {
            Text("Investment")
                .font(.interMedium(size: 12))
                .foregroundStyle(Color.lightGrayTitle)
            HStack {
                Button {
                    endTextEditing()
                    model.minusInvestmentValue()
                } label: {
                    Image("minusCircle")
                        .padding(.leading, Constants.innerHorizontalInset)
                }
                .buttonStyle(.plain)
                TextField("", text: $investmentText) {
                    
                }
                .onChange(of: investmentText) {
                    model.updateInvestmentValue(getNumericInvestmentString())
                }
                .focused($investmentDidEditing)
                .environment(\.colorScheme, .dark)
                .keyboardType(.numberPad)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
                .font(.interBold(size: 16))
                Button {
                    endTextEditing()
                    model.plusInvestmentValue()
                } label: {
                    Image("addCircle")
                        .padding(.trailing, Constants.innerHorizontalInset)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: screenHeight * Constants.buttonHeightScale
        )
        .background(Color.balance)
        .clipShape(
            RoundedRectangle(
                cornerRadius: Constants.radius,
                style: .continuous
            )
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: Constants.radius,
                style: .continuous
            ).stroke(
                investmentDidEditing ? Color.appGreen : .clear,
                lineWidth: 1
            )
        )
    }
    
    // MARK: - Sell
    
    var sell: some View {
        Button {
            print("Sell did tap")
        } label: {
            Text("Sell")
                .padding(.leading, Constants.titleHInset)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.interMedium(size: 24))
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: screenHeight * Constants.buttonHeightScale
        )
        .background(Color.appRed)
        .clipShape(
            RoundedRectangle(
                cornerRadius: Constants.radius,
                style: .continuous
            )
        )
    }
    
    // MARK: - Buy
    
    var buy: some View {
        Button {
            print("Buy did tap")
        } label: {
            Text("Buy")
                .padding(.leading, Constants.titleHInset)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.interMedium(size: 24))
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: screenHeight * Constants.buttonHeightScale
        )
        .background(Color.appGreen)
        .clipShape(
            RoundedRectangle(
                cornerRadius: Constants.radius,
                style: .continuous
            )
        )
    }
    
    // MARK: - Private Methods
    
    private func endTextEditing() {
        timerDidEditing = false
        investmentDidEditing = false
    }
    
    private func getNumericString() -> String {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        return timerText.components(separatedBy: allowedCharacterSet.inverted).joined()
    }
    
    private func getNumericInvestmentString() -> String {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        return investmentText.components(separatedBy: allowedCharacterSet.inverted).joined()
    }
    
    private func timerPlus() {
        let numericString = getNumericString()
        guard let value = Int(numericString) else { return }
        let finalString = addLeadingZeros(to: String(value + 1))
        let formatString = formatTimeInput(finalString)
        model.updateTimer(string: formatString)
    }
    
    private func timerMinus() {
        let numericString = getNumericString()
        guard let value = Int(numericString) else { return }
        let finalString = addLeadingZeros(to: String(value - 1))
        let formatString = formatTimeInput(finalString)
        model.updateTimer(string: formatString)
    }
    
    func addLeadingZeros(to input: String) -> String {
        guard input.count < 4 else {
            return input
        }
        let numberOfZerosToAdd = 4 - input.count
        let zeros = String(repeating: "0", count: numberOfZerosToAdd)
        return zeros + input
    }
    
    private func formatTimeInput(_ numericString: String) -> String {
        let limitedString = String(numericString.prefix(4))
        let formattedString: String
        if limitedString.count > 2 {
            let index = limitedString.index(limitedString.startIndex, offsetBy: 2)
            let hour = limitedString[..<index]
            let minute = limitedString[index...]
            formattedString = "\(hour):\(minute)"
        } else {
            formattedString = limitedString
        }
        return formattedString
    }
}

// MARK: - Preview

#Preview {
    TradeButtons(
        model: .init(delegate: nil),
        screenHeight: 812,
        currencyPairTitle: CurrencyPair.eur.buttonTitle,
        timerText: HomeTradeModel.getTestData().timer,
        investmentText: String(
            HomeTradeModel.getTestData().investment
        ),
        keyboardIsOpen: .constant(true)
    )
}
