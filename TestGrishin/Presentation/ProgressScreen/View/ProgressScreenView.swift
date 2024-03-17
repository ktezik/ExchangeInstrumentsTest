//
//  ProgressScreenView.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI

struct ProgressScreenView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let progressBarHeight: CGFloat = 24
        static let progressBarInsets = EdgeInsets(
            top: 0, leading: 37, bottom: 0, trailing: 38
        )
    }
    
    // MARK: - Public Properties
    
    var model: ProgressScreenModel
    @State var progressValue: String
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            progress
                .onReceive(model.$progressValue) { _ in
                    withAnimation {
                        progressValue = model.getProgressTitle()
                    }
                    model.updateProgressValue()
                }
        }
    }
    
    // MARK: - Progress
    
    var progress: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack {
                    HStack {
                        Color
                            .appGreen
                            .frame(
                                maxWidth: getProgressWidth(for: geometry.size.width),
                                maxHeight: Constants.progressBarHeight,
                                alignment: .leading
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: Constants.progressBarHeight / 2
                                )
                            )
                        if model.progressLessThenMax() {
                            Spacer()
                        }
                    }
                    Text(progressValue)
                        .foregroundStyle(Color.white)
                        .font(Font.interBold(size: 16))
                }
                .background(Color.gray)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: Constants.progressBarHeight / 2
                    )
                )
                .clipped()
                .padding(Constants.progressBarInsets)
                Spacer()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getProgressWidth(for width: CGFloat) -> CGFloat {
        var actualWidth = width - Constants.progressBarInsets.leading
        actualWidth -= Constants.progressBarInsets.trailing
        return actualWidth * CGFloat(model.progressValue) / 100
    }
}

// MARK: - Preview

#Preview {
    ProgressScreenView(
        model: ProgressScreenModel(delegate: nil),
        progressValue: "58%"
    )
}
