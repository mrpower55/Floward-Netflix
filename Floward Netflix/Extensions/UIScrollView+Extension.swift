//
//  UIScrollView.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 16/09/2022.
//

import Foundation
import UIKit

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
