//
//  NetworkLayer.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 14/09/2022.
//

import Foundation

enum APIError: Error {
    case APIFailure
}

class NetworkLayer {
    static let shared = NetworkLayer()
    
    func getTrendingMovies(completion: @escaping (Result<[Media], Error>) -> Void) {
        guard let url = URL(string: AppConstants.tradingMoviesURL) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let results = try JSONDecoder().decode(TrendingMediaResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.APIFailure))
            }
        }
        
        task.resume()
    }
    
    func getTrendingTVShow(completion: @escaping (Result<[Media], Error>) -> Void) {
        guard let url = URL(string: AppConstants.tradingTvsURL) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMediaResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.APIFailure))
            }
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Media], Error>) -> Void) {
        guard let url = URL(string: AppConstants.upcomingMoviesURL) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMediaResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.APIFailure))
            }
        }
        
        task.resume()
    }
    
    func getTopRatedMedia(completion: @escaping (Result<[Media], Error>) -> Void) {
        guard let url = URL(string: AppConstants.topRatedMediaURL) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMediaResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.APIFailure))
            }
        }
        
        task.resume()
    }
    
    func getPopularMedia(completion: @escaping (Result<[Media], Error>) -> Void) {
        guard let url = URL(string: AppConstants.popularMediaURL) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMediaResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.APIFailure))
            }
        }
        
        task.resume()
    }
}
