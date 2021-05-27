//
//  BaseService.swift
//  Dotabase
//
//  Created by zhussupov on 27.05.2021.
//

import Foundation

class BaseService {
    func makeRequest<T: Codable>(urlString: String, completion: @escaping (T) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    print(error ?? "Unknown error")
                    return
                }
                if let decoded = self.parseJSON(data) as T? {
                    DispatchQueue.main.async {
                        completion(decoded)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON<T: Codable>(_ hero: Data) -> T? {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: hero) else {
            print("Error decoding")
            return nil
        }
        return decodedData
    }
}
