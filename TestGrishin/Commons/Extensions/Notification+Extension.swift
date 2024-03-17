//
//  Notification+Extension.swift
//  TestGrishin
//
//  Created by Иван Гришин on 17.03.2024.
//

import UIKit

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
