//
//  AppConstants.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 14/09/2022.
//

import Foundation
import UIKit

class AppConstants {
    static let shared = AppConstants()
    
    static let API_KEY = "43d31d32e22f044a5801eb6f0eeda50a"
    static let themoviedbAPIMainURL = "https://api.themoviedb.org/3/"
    static let postersMainURL = "https://image.tmdb.org/t/p/w500/"
    
    static let tradingMoviesURL  = "trending/movie/day".apiURL
    static let tradingTvsURL     = "trending/tv/day".apiURL
    static let upcomingMoviesURL = "movie/upcoming".apiURL
    static let popularMediaURL   = "movie/popular".apiURL
    static let topRatedMediaURL  = "movie/top_rated".apiURL
}

class AppColors {
    static let transparent = UIColor.clear
    static let black = UIColor.black
    static let white = UIColor.white
    static let systemBackground = UIColor.systemBackground
}
