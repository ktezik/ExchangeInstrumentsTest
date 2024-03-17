//
//  HomeCurrencyPairView.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI

struct HomeCurrencyPairView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let topInset: CGFloat = 20
        static let backButtonInset = EdgeInsets(
            top: 22, leading: 9, bottom: 0, trailing: 0
        )
        static let listVerticalSpacing: CGFloat = 20
        static let listHorizontalSpacing: CGFloat = 21
        static let listInsets = EdgeInsets(
            top: 37, leading: 37, bottom: 0, trailing: 37
        )
    }
    
    // MARK: - Public Properties
    
    let model: HomeScreenModel
    @Environment(\.presentationMode) private var presentationMode
    @State var selectedIndex: IndexPath?
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Text("Currency pair")
                        .font(.interBold(size: 22))
                        .foregroundStyle(Color.white)
                        .padding(.top, Constants.topInset)
                        .frame(maxWidth: .infinity, alignment: .center)
                    list
                        .padding(Constants.listInsets)
                }
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("leftArrow")
                        .padding(Constants.backButtonInset)
                }
            }
            
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.tradeBackground)
        .onReceive(model.$currencySelectedPairIndex) { newIndexPath in
            selectedIndex = newIndexPath
        }
    }
    
    // MARK: - List
    
    var list: some View {
        VStack(spacing: Constants.listVerticalSpacing) {
            ForEach(model.currencyPairModel.indices, id: \.self) { sectionIndex in
                HStack(spacing: Constants.listHorizontalSpacing) {
                    ForEach(
                        model.currencyPairModel[sectionIndex].indices,
                        id: \.self
                    ) { itemIndex in
                        CurrencyPairCell(
                            isSelected: IndexPath(item: itemIndex, section: sectionIndex) == selectedIndex,
                            currencyPair: model.currencyPairModel[sectionIndex][itemIndex]
                        ) { selectedModel in
                            let indexPath = IndexPath(
                                item: itemIndex,
                                section: sectionIndex
                            )
                            model.updateCurrencyPair(
                                indexPath: indexPath,
                                and: selectedModel
                            )
                            withAnimation {
                                selectedIndex = indexPath
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeCurrencyPairView(
        model: .init(delegate: nil),
        selectedIndex: nil
    )
}
