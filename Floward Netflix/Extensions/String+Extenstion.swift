//
//  String.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 14/09/2022.
//

import Foundation

extension String {
    var apiURL: String { return "\(AppConstants.themoviedbAPIMainURL)\(self)?api_key=\(AppConstants.API_KEY)&language=en-US" }
    
    var posterURL: String { return "\(AppConstants.postersMainURL)\(self)" }
}
