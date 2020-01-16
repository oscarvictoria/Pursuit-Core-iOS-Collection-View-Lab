//
//  CountriesAPIClient.swift
//  CollectionViewsLab
//
//  Created by Oscar Victoria Gonzalez  on 1/15/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import NetworkHelper

struct CountriesAPIClient {
    static func getCountries(completion: @escaping (Result <[Countries],AppError>)->()) {
        let endpointURLString = "https://restcountries.eu/rest/v2/all"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let country = try JSONDecoder().decode([Countries].self, from: data)
                    completion(.success(country))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
