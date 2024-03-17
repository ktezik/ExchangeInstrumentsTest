//
//  ProgressScreenController.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import UIKit
import SwiftUI

final class ProgressScreenController: UIViewController {

    // MARK: - Private Properties
    
    private lazy var model = ProgressScreenModel(delegate: self)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHostingController()
    }
    
    // MARK: - Private Methods
    
    private func configureHostingController() {
        let contentView = ProgressScreenView(model: model, progressValue: model.getProgressTitle())
        let cardHostingController = UIHostingController(rootView: contentView)
        cardHostingController.view.backgroundColor = .clear
        addChild(controller: cardHostingController, rootView: view)
    }
}

// MARK: - ProgressScreenModelDelegate

extension ProgressScreenController: ProgressScreenModelDelegate {
    func progressDidEnd() {
        print(#function)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            granted ? print("Notification authorization granted") : print("Notification authorization denied")
            DispatchQueue.main.async {
                self.present(HomeScreenController(), animated: false)
            }
        }
    }
}
