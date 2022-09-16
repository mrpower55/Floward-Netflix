//
//  UIImageView+Extension.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 14/09/2022.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func displayImage(_ path: String) {
        guard let url = URL(string: path.posterURL) else { return }
        
        DispatchQueue.main.async {
            self.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            self.sd_setImage(with: url)
        }
    }
}
