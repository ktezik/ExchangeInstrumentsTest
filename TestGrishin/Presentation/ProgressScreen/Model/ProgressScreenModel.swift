//
//  ProgressScreenModel.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI

protocol ProgressScreenModelDelegate: AnyObject {
    func progressDidEnd()
}

final class ProgressScreenModel: ObservableObject {
    
    // MARK: - Constants
    
    private enum Constants {
        static let maxProgressValue = 100
    }
    
    // MARK: - Public Properties
    
    @Published private(set) var progressValue: Int
    weak var delegate: ProgressScreenModelDelegate?
    
    // MARK: - Initialization
    
    init(progressValue: Int = 7, delegate: ProgressScreenModelDelegate?) {
        self.progressValue = progressValue
        self.delegate = delegate
    }
    
    // MARK: - Public Methods
    
    func progressLessThenMax() -> Bool {
        progressValue < Constants.maxProgressValue
    }
    
    func getProgressTitle() -> String {
        "\(progressValue)%"
    }
    
    func updateProgressValue() {
        guard progressValue < Constants.maxProgressValue else {
            delegate?.progressDidEnd()
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.progressValue += 1
        }
    }
}
