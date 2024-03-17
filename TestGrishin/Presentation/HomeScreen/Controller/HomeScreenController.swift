//
//  HomeScreenController.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import UIKit
import SwiftUI

final class HomeScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var model = HomeScreenModel(delegate: self)
    private var timer: Timer?
    
    // MARK: - Initializer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHostingController()
        setupTimer()
    }
    
    // MARK: - Private Methods
    
    private func configureHostingController() {
        let contentView = HomeScreenView(model: model)
        let cardHostingController = UIHostingController(rootView: contentView)
        cardHostingController.view.backgroundColor = .clear
        addChild(controller: cardHostingController, rootView: view)
    }
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 5,
            repeats: true
        ) { _ in
            self.model.updateTopModel()
        }
    }
}

// MARK: - HomeScreenModelDelegate

extension HomeScreenController: HomeScreenModelDelegate {
    func errorReport(_ error: Error) {
        let alertVC = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alertVC, animated: true)
        }
    }
}
