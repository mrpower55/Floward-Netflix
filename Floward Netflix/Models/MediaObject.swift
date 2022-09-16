//
//  Title.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 14/09/2022.
//

import Foundation

struct TrendingMediaResponse: Codable {
    let results: [Media]
}

struct Media: Codable {
    let id: Int
    let adult: Bool?
    let backdrop_path: String?
    let name: String?
    let title: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let genre_ids: [Int]?
    let popularity: Double?
    let release_date: String?
    let first_air_date: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
    
    func getTitle() -> String {
        return "\(self.title ?? "")".isEmpty ? "\(self.name ?? "")" : "\(self.title ?? "")"
    }
    
    func getMediaType() -> String {
        return self.media_type?.isEmpty ?? true ? "" : "(\(self.media_type?.capitalized ?? ""))"
    }
}
