//
//  UIImage+Extenstion.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 14/09/2022.
//

import Foundation
import UIKit

enum Image: String {
    case netflixLogo = "netflixLogo"
    case netflixLogoSmall = "netflixLogoSmall"
    case searchIcon = "magnifyingglass"
    case profileIcon = "person.crop.circle"
    case playIcon = "play"
    case infoIcon = "info.circle"
}

extension UIImage {
    static let netflixLogo = UIImage(named: Image.netflixLogo.rawValue)!
    static let netflixLogoSmall = UIImage(named: Image.netflixLogoSmall.rawValue)?.withRenderingMode(.alwaysOriginal)
    static let searchIcon = UIImage(systemName: Image.searchIcon.rawValue)!
    static let profileIcon = UIImage(systemName: Image.profileIcon.rawValue)!
    static let playIcon = UIImage(systemName: Image.playIcon.rawValue)!
    static let infoIcon = UIImage(systemName: Image.infoIcon.rawValue)!
}
