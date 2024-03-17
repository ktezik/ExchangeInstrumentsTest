//
//  UIViewController+Extension.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI

extension Font {
    static func interBold(size: CGFloat) -> Font {
        Font.custom("Inter-Bold", size: size)
    }
    static func interRegular(size: CGFloat) -> Font {
        Font.custom("Inter-Regular", size: size)
    }
    static func interSemiBold(size: CGFloat) -> Font {
        Font.custom("Inter-SemiBold", size: size)
    }
    static func interMedium(size: CGFloat) -> Font {
        Font.custom("Inter-Medium", size: size)
    }
    static func interExtraBold(size: CGFloat) -> Font {
        Font.custom("Inter-ExtraBold", size: size)
    }
}
